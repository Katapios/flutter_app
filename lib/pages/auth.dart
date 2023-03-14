import 'package:denns_introduction_app/pages/products.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  //const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // background
            onPrimary: Colors.white, // foreground
          ),
          //style: ElevatedButton.styleFrom(backgroundColor: Colors.green),

          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
