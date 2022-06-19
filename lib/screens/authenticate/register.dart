import 'package:travile/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:travile/shared/constants.dart';
import 'package:travile/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  const Register({Key? key, required this.toggleView }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';

  // text field state
  String email = '';
  String password = '';
  String username = '';

  @override
  Widget build(BuildContext context) {
    return loading? const Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign up to Travile'),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('Sign In'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key:_formKey,
          child: SingleChildScrollView (
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'email'),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'password'),
                  obscureText: true,                
                  validator: (val) => val!.length < 6 ? 'Enter a password 6+ characters long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'username'),
                  obscureText: true,                
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => username = val);
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink[400],
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password, username);

                      if(result == null) {
                        setState(() {
                          error = 'Please supply a valid email';
                          loading = false;
                        });
                      }
                    }
                  }
                ),
              const SizedBox(height: 12.0),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                ), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}