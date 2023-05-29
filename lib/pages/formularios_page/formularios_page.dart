import 'package:flutter/material.dart';

class FormulariosPage extends StatefulWidget {
  const FormulariosPage({Key? key}) : super(key: key);

  @override
  State<FormulariosPage> createState() => _FormulariosPageState();
}

class _FormulariosPageState extends State<FormulariosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Formularios Page'),
      ),
    );
  }
}
