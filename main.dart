import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';

// Array of button
  final List<String> buttons = [
    'AC',
    'DEL',
    '+/-',
    '%',
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
    '.',
    '0',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red[700],
        title: new Text("Calculator"),
      ), //AppBar
      backgroundColor: Colors.teal[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (index == 0) {
                      return CustomButton(
                        buttonTapped: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        },
                        text: buttons[index],
                        color: (Colors.red[50])!,
                        textColor: Colors.black,
                      );
                    }

                    // +/- button
                    else if (index == 2) {
                      return CustomButton(
                        buttonTapped: () {
                          setState(() {
                            userInput = '-'+ userInput;
                          });

                        },
                        text: buttons[index],
                        color: (Colors.red[50])!,
                        textColor: Colors.black,
                      );
                    }
                    // % Button
                    else if (index == 3) {
                      return CustomButton(
                        buttonTapped: () {
                          setState(() {
                            userInput += buttons[index];
                          });
                        },
                        text: buttons[index],
                        color: (Colors.red[50])!,
                        textColor: Colors.black,
                      );
                    }
                    // Delete Button
                    else if (index == 1) {
                      return CustomButton(
                        buttonTapped: () {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          });
                        },
                        text: buttons[index],
                        color: (Colors.red[50])!,
                        textColor: Colors.black,
                      );
                    }
                    // Equal_to Button
                    else if (index == 18) {
                      return CustomButton(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        text: buttons[index],
                        color: (Colors.blue[700])!,
                        textColor: Colors.white,
                      );
                    }

                    // other buttons
                    else {
                      return CustomButton(
                        buttonTapped: () {
                          setState(() {
                            userInput += buttons[index];
                          });
                        },
                        text: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.red
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }), // GridView.builder
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}

class CustomButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final VoidCallback buttonTapped;

  const CustomButton({Key? key,
    required this.color,
    required this.textColor,
    required this.text,
    required this.buttonTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 20),
          ),
        ),
      ),
    );
  }
}




