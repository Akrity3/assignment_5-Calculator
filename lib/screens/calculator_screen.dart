import 'package:flutter/material.dart';

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

