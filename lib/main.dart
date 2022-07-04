import 'package:calculator_application/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  var inputUser = '';
  var result = '';
  void buttonPressed(String text) {
    setState(() {
      inputUser = inputUser + text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: backgroundGreyDark,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          inputUser,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: textGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          result,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 64),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: backgroundGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow('ac', 'ce', '%', '/'),
                      getRow('7', '8', '9', '*'),
                      getRow('4', '5', '6', '-'),
                      getRow('1', '2', '3', '+'),
                      getRow('00', '0', '.', '='),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            if (text1 == 'ac') {
              setState(() {
                inputUser = '';
                result = '';
              });
            } else {
              buttonPressed(text1);
            }
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              text1,
              style: TextStyle(
                fontSize: 26,
                color: getColorOperator(text1),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (text2 == 'ce') {
              setState(() {
                if (inputUser.length > 0) {
                  inputUser = inputUser.substring(0, inputUser.length - 1);
                }
              });
            } else {
              buttonPressed(text2);
            }
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 26,
                color: getColorOperator(text2),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            buttonPressed(text3);
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              text3,
              style: TextStyle(
                fontSize: 26,
                color: getColorOperator(text3),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputUser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                result = eval.toString();
              });
            } else {
              buttonPressed(text4);
            }
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              text4,
              style: TextStyle(
                fontSize: 26,
                color: getColorOperator(text4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool isOperator(String text) {
    var list = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getColorOperator(String text) {
    if (isOperator(text)) {
      return textGreen;
    }

    return textGrey;
  }
}
