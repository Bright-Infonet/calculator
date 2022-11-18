import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';

  final List<String> button = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style:
                            const TextStyle(fontSize: 25, color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: const TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                  itemCount: button.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return IButton(
                        buttontapped: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        },
                        buttonText: button[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    } else if (index == 1) {
                      return IButton(
                        buttonText: button[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    } else if (index == 2) {
                      return IButton(
                        buttontapped: () {
                          setState(() {
                            userInput += button[index];
                          });
                        },
                        buttonText: button[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    } else if (index == 3) {
                      return IButton(
                        buttontapped: () {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          });
                        },
                        buttonText: button[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    } else if (index == 18) {
                      return IButton(
                        buttontapped: () {
                          setState(() {
                            equal();
                          });
                        },
                        buttonText: button[index],
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      );
                    } else {
                      return IButton(
                        buttontapped: () {
                          setState(() {
                            userInput += button[index];
                          });
                        },
                        buttonText: button[index],
                        color: isOperat(button[index])
                            ? Colors.blueAccent
                            : Colors.white,
                        textColor: isOperat(button[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperat(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equal() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}

class IButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

  const IButton(
      {super.key, this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRRect(
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
