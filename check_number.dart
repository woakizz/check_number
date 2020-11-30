import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:powers/powers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _form = GlobalKey();
  final TextEditingController controller = TextEditingController();
  String message;

  void _showDialog(String message, int value) {
    // flutter defined function
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('$value'),
          content: Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Row(
              children: <Widget>[
                FlatButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Check your number'),
        centerTitle: true,
      ),
      body: Form(
        key: _form,
        child: Column(
          children: <Widget>[
            const Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Please input a number to see if it\'s square or triangular',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(),
                validator: (String value) {
                  final double amount = double.tryParse(value);
                  if (amount == null) {
                    return 'Please enter a number';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (!_form.currentState.validate()) {
            setState(
              () {
                message = null;
              },
            );
            return;
          }

          final double value = double.parse(controller.text.trim());

          setState(
            () {
              message='Number is ';
              if (value.toInt().isSquare && value.toInt().isCube) {
                message += 'square and cube';
              } else if(value.toInt().isSquare){
                message += 'not cube but is square ';
              } else if(value.toInt().isCube) {
                message += 'cube but is not square';
              } else
                message += 'nothing';
              _showDialog(message, value.toInt());
            },
          );
        },
      ),
    );
  }
}
