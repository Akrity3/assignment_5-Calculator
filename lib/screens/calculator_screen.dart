import 'package:flutter/material.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  static const List<Map<String, String>> _buttons = [
    {'label':'C',   'type': 'clear'},
    {'label':'+/-', 'type': 'special'},
    {'label':'%',   'type': 'operator'},
    {'label':'÷',   'type': 'operator'},

    {'label':'7',   'type': 'number'},
    {'label':'8',   'type': 'number'},
    {'label':'9',   'type': 'number'},
    {'label':'x',   'type': 'operator'},

    {'label':'4',   'type': 'number'},
    {'label':'5',   'type': 'number'},
    {'label': '6',   'type': 'number'},
    {'label':'-',   'type': 'operator'},

    {'label': '1',   'type': 'number'},
    {'label': '2',   'type': 'number'},
    {'label': '3',   'type': 'number'},
    {'label': '+',   'type': 'operator'},

    {'label': '⌫',   'type': 'backspace'},
    {'label': '0',   'type': 'number'},
    {'label': '.',   'type': 'number'},
    {'label': '=',   'type': 'equals'},
  ];

  //Colors 
  static const Color _bgColor = Color(0xFF0F0F0F);
  static const Color _numberBg = Color(0xFF1E1E1E);
  static const Color _operatorBg= Color(0xFFFF9500);
  static const Color _specialBg= Color(0xFF2C2C2E);
  static const Color _accentOrange= Color(0xFFFF9500);
  static const Color _primaryText = Colors.white;
  static const Color _dimText= Color(0xFF8E8E93);

  Color _bgFor(String type) {
    switch (type) {
      case 'operator':
      case 'equals':   
      return _operatorBg;

      case 'clear':
      case 'backspace':
      case 'special':  
      return _specialBg;

      default:         
      return _numberBg;
    }
  }

  Color _fgFor(String type) {
    switch (type) {
      case 'operator':
      case 'equals':   
      return Colors.white;

      case 'clear':
      case 'backspace':
      return _accentOrange;

      default:         
      return _primaryText;
    }
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
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),

        child: Column(
          children: [
            
            // Display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.06),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [ const Text( // expression line
                    '128 + 64',
                    style: TextStyle(
                      color: _dimText,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                  const SizedBox(height: 4),
                  const FittedBox(  // main number
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '192',
                      style: TextStyle(
                        color: _primaryText,
                        fontSize: 64,
                        fontWeight: FontWeight.w200,
                        letterSpacing: -2,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            //Button grid
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.85,
                ),
                itemCount: _buttons.length,
                itemBuilder: (context, index) {
                  final btn   = _buttons[index];
                  final label = btn['label']!;
                  final type  = btn['type']!;
                  return _CalcButton(
                    label: label,
                    bgColor: _bgFor(type),
                    fgColor: _fgFor(type),
                    isOperator: type == 'operator' || type == 'equals',
                  );
                },
              ),
            ),
            ],

        ),),
    );

  }
}

// button 
class _CalcButton extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color fgColor;
  final bool isOperator;

  const _CalcButton({
    required this.label,
    required this.bgColor,
    required this.fgColor,
    this.isOperator = false,
  });



  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: isOperator
                ? _CalcButton._orangeGlow
                : Colors.black.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: fgColor,
            fontSize: label == '⌫' ? 24 : 28,
            fontWeight: isOperator ? FontWeight.w500 : FontWeight.w300,
          ),
        ),
      ),
      
    );
  }

  static final Color _orangeGlow =
      const Color(0xFFFF9500).withOpacity(0.30);
}