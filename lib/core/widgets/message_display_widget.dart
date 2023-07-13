import 'package:flutter/material.dart';

//Message in the centre of screen //like: "No data"

class MessageDisplayWidget extends StatelessWidget {
  final String message;
  const MessageDisplayWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
          child: SingleChildScrollView(
        child: Text(
          message,
          style: const TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      )),
    );
  }
}
