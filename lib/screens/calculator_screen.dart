import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  static const List<String> _buttons = [
    'C',  
    '^',  
    '/',  
    '<-',

    '1',  
    '2',  
    '3',  
    '+',

    '4',  
    '5',  
    '6',  
    '-',

    '7',  
    '8',  
    '9',  
    '*',

    '%',  
    '0',  
    '.',  
    '=', 
  ];

  String _display = '';

  String _firstNumber  = '';   // stores first number user types
  String _operator     = '';   // stores the operator (+, -, *, etc.)
  String _secondNumber = '';   // stores second number user types
  bool   _hasOperator  = false; // tracks whether operator has been pressed

  //Colors 
  static const Color _bgColor = Color(0xFF0F0F0F);
  static const Color _numberBg = Color(0xFF1E1E1E);
  static const Color _operatorBg= Color(0xFFFF9500);
  static const Color _specialBg= Color(0xFF2C2C2E);
  static const Color _accentOrange= Color(0xFFFF9500);
  static const Color _primaryText = Colors.white;
 

  Color _bgFor(String label) {
    if (label == 'C' || label == '<-') 
      return _specialBg;
    if ('+-*/%'.contains(label) || label == '/') 
      return _operatorBg;
    if (label == '=') 
      return _operatorBg;
      
    return _numberBg;
  }

  Color _fgFor(String label) {
    if (label == 'C' || label == '<-') 
      return _accentOrange;
    if ('+-*/%='.contains(label) || label == '/') 
      return Colors.white;

    return _primaryText;
  }

  // buttons behaviours
  void _onButtonPressed(String label) {
    setState(() {

      // ── Clear: resets everything ──
      if (label == 'C') {
        _firstNumber  = '';
        _operator     = '';
        _secondNumber = '';
        _hasOperator  = false;
        _display      = '';
        return;
      }

      //Backspace
      if (label == '<-') {
        if (_display.isNotEmpty) {
          final String removed = _display[_display.length - 1];

          // if the removed character was the operator, reset operator state
          if (removed == _operator) {
            _operator    = '';
            _hasOperator = false;
          } else if (_hasOperator) {
            // removing from second number
            _secondNumber = _secondNumber.isNotEmpty
                ? _secondNumber.substring(0, _secondNumber.length - 1)
                : '';
          } else {
            // removing from first number
            _firstNumber = _firstNumber.isNotEmpty
                ? _firstNumber.substring(0, _firstNumber.length - 1)
                : '';
          }
          _display = _display.substring(0, _display.length - 1);
        }
        return;
      }

      // Operator pressed (+, -, *, /, %, ^) 
      if ('+-*/^%'.contains(label)) {
        // only set operator if first number exists and no operator set yet
        if (_firstNumber.isNotEmpty && _operator.isEmpty) {
          _operator    = label;
          _hasOperator = true;
          _display     += label;
        }
        return;
      }

      //Equals
      if (label == '=') {
        // do nothing if any part is missing
        if (_firstNumber.isEmpty || _operator.isEmpty || _secondNumber.isEmpty) {
          return;
        }

        final double a = double.parse(_firstNumber);
        final double b = double.parse(_secondNumber);
        double result  = 0;

        switch (_operator) {
          case '+': result = a + b;     
          break;

          case '-': result = a - b;                        
          break;
          case '*': result = a * b;                        
          break;

          case '/': result = b != 0 ? a / b : 0;          
          break; // prevent divide by zero

          case '%': result = a % b;                        
          break;

          case '^': result = pow(a, b).toDouble();         
          break; 
        }

        // show as integer if result has no decimal part 
        final String resultStr = result == result.truncateToDouble()
            ? result.toInt().toString()
            : result.toString();

        // display
        _display      = '$_firstNumber$_operator$_secondNumber=$resultStr';

        // store result as first number so user can chain calculations
        _firstNumber  = resultStr;
        _operator     = '';
        _secondNumber = '';
        _hasOperator  = false;
        return;
      }

      // Number or dot pressed 

      // prevent multiple dots in the same number
      if (label == '.') {
        if (_hasOperator) {
          if (_secondNumber.contains('.')) return;
        } else {
          if (_firstNumber.contains('.')) return;
        }
      }

      // append to correct number based on whether operator is set
      if (_hasOperator) {
        _secondNumber += label;
      } else {
        _firstNumber  += label;
      }
      _display += label;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,

      appBar: AppBar(
        backgroundColor: _bgColor,

        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Calculator',
          style: TextStyle(
            color: _primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          children: [
            
            // Display
            Container(
              width: double.infinity,
              height: 110,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.centerRight,

              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(10), //
                border: Border.all(
                  color: Colors.white.withOpacity(0.06),
                ),
              ),

              child: Text(
                _display,
                style: const TextStyle(fontSize: 58, color: _primaryText),
              ),

            ),

            const SizedBox(height: 23), //

            //Button grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.77,
                children: [
                  for (final label in _buttons)
                    ElevatedButton(
                      onPressed: () {
                        if (label == 'C') {
                          setState(() => _display = '');
                        } else if (label == '<-') {
                          if (_display.isNotEmpty) {
                            setState(() {
                              _display = _display.substring(
                                0,
                                _display.length - 1,
                              );
                            });
                          }
                        } else if (label == '=') {
                          // TODO

                        } else if ('+-*/%'.contains(label) || label == '/') {
                          // TODO

                        } else {
                          setState(() => _display += label);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _bgFor(label),
                        foregroundColor: _fgFor(label),
                        elevation: label == '=' ||
                                '+-*/%'.contains(label) ||
                                label == '/'
                            ? 4
                            : 2,
                        shadowColor: label == '=' ||
                                '+-*/%'.contains(label) ||
                                label == '/'
                            ? _accentOrange.withOpacity(0.30)
                            : Colors.black.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        label,
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                ],
              ),
            ),
            ],

        ),
      ),
    );

  }
}

