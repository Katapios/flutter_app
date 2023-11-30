import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';
import '../models/auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeySwitchListTile = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: const AssetImage('assets/10.1 background.jpg'),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'E-Mail', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (dynamic value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      onChanged: (String value) {
        setState(() {
          _formData['email'] = value;
        });
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      controller: _passwordTextController,
      validator: (dynamic value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
        return null;
      },
      onChanged: (String value) {
        setState(() {
          _formData['password'] = value;
        });
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
        decoration: const InputDecoration(
            labelText: 'Confirm Password',
            filled: true,
            fillColor: Colors.white),
        obscureText: true,
        //controller: _passwordTextController,
        validator: (dynamic value) {
          if (_passwordTextController.text != value) {
            return 'Passwords do not match.';
          }
          return null;
        });
  }

  Widget _buildAcceptSwich() {
    return FormField(
      key: _formKeySwitchListTile,
      initialValue: false,
      validator: (val) {
        if (val == false) return 'Please accept the terms';
        return null;
      },
      builder: (FormFieldState<bool> field) {
        return InputDecorator(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            errorText: field.errorText,
          ),
          child: SwitchListTile(
            contentPadding: EdgeInsets.all(0),
            activeColor: Colors.amber,
            title: const Text("Accept Terms"),
            value: field.value!,
            onChanged: (value) {
              field.didChange(value);
              _formData['acceptTerms'] = value;
            },
          ),
        );
      },
    );
  }

  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState!.validate() || !_formData['acceptTerms']) {
      return;
    }
    _formKey.currentState!.save();
    Map<String, dynamic> successInformation;
      successInformation =
          await authenticate(_formData['email'], _formData['password'], _authMode);
    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/products');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An Error Occured'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay'))
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildEmailTextField(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordTextField(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    _authMode == AuthMode.Signup
                        ? _buildPasswordConfirmTextField()
                        : Container(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    _buildAcceptSwich(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _authMode = _authMode == AuthMode.Login
                              ? AuthMode.Signup
                              : AuthMode.Login;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white38),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.fromLTRB(10, 5, 10, 5)),
                      ),
                      child: Text(
                        'Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}',
                        style: TextStyle(
                          height: 1.0,
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget? child,
                          MainModel model) {
                        return model.isLoading
                            ? CircularProgressIndicator(color: Colors.green)
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.amber, // foreground
                                ),
                                //style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                onPressed: () =>
                                    _submitForm(model.authenticate),
                                child: Text(_authMode == AuthMode.Login
                                    ? 'Login'
                                    : 'Signup'),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
