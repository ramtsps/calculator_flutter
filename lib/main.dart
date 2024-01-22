import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "";
  String previousValue = "";

  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  @override
  Widget build(BuildContext context) {
    operations(String value) {
      if (value == "CLEAR") {
        _output = "0";
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
        previousValue = "";
      } else if (value == "+" || value == "-" || value == "/" || value == "X") {
        print(output);
        num1 = double.parse(output);
        operand = value;
        previousValue = output + " " + operand;
        _output = "0";
      } else if (value == ".") {
        if (_output.contains(".")) {
          print("Already contains a decimal");
          return;
        } else {
          _output = _output + value;
        }
      } else if (value == "=") {
        num2 = double.parse(output);
        if (operand == "+") {
          _output = (num1 + num2).toString();
        }
        if (operand == "-") {
          _output = (num1 - num2).toString();
        }
        if (operand == "X") {
          _output = (num1 * num2).toString();
        }
        if (operand == "/") {
          _output = (num1 / num2).toString();
        }
        previousValue = output + " " + operand + " " + num2.toString();
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      } else {
        _output = _output + value;
      }

      setState(() {
        output = double.parse(_output).toStringAsFixed(2);
      });
    }

    Widget button(String buttonText, Function() onPressed) {
      return Expanded(
        child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(24.0)),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator App"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    previousValue,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    output,
                    style: const TextStyle(
                        fontSize: 36.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Expanded(child: Divider()),
            Column(
              children: [
                Row(children: [
                  button("7", () => operations("7")),
                  button("8", () => operations("8")),
                  button("9", () => operations("9")),
                  button("/", () => operations("/")),
                ]),
                Row(children: [
                  button("4", () => operations("4")),
                  button("5", () => operations("5")),
                  button("6", () => operations("6")),
                  button("X", () => operations("X")),
                ]),
                Row(children: [
                  button("1", () => operations("1")),
                  button("2", () => operations("2")),
                  button("3", () => operations("3")),
                  button("-", () => operations("-")),
                ]),
                Row(children: [
                  button(".", () => operations(".")),
                  button("0", () => operations("0")),
                  button("00", () => operations("00")),
                  button("+", () => operations("+")),
                ]),
                Row(children: [
                  button("CLEAR", () => operations("CLEAR")),
                  button("=", () => operations("=")),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
