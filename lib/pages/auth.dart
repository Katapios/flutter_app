import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late String _emailValue;
  late String _passwordValue;
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
              image: AssetImage('assets/10.1 background.jpg'),
            ),
          ),
          padding: EdgeInsets.all(10.0),
          child: Center(child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'E-Mail',filled: true, fillColor: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {
                    setState(() {
                      _emailValue = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10.9,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Password',filled: true, fillColor: Colors.white),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      _passwordValue = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10.9,
                ),
                SwitchListTile(
                  tileColor: Colors.amber,
                  activeColor: Colors.amber,
                  inactiveThumbColor: Colors.white,
                  value: _acceptTerms,
                  onChanged: (bool value) {
                    setState(() {
                      _acceptTerms = value;
                    });
                  },
                  title: Text('Accept Terms',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
                SizedBox(
                  height: 10.9,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    //style: ElevatedButton.styleFrom(backgroundColor: Colors.green),

                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/products');
                    },
                    child: Text('Login'),
                  ),
                ),
              ],
            ),

          ),),
        ));
  }
}
