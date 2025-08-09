import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    Key? key,
    this.title,
    this.description,
    this.buttonText,
    this.numberOfStepsOnReturn,
    this.success = false,
  }) : super(key: key);

  final String? title;
  final String? description;
  final String? buttonText;
  final int? numberOfStepsOnReturn;
  final bool? success;

  @override
  Widget build(BuildContext context) =>  _buildScreen(context);

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const SafeArea(
            child: Center(
          child: Text('Незивестная ошибка'),
        )));
  }
}
