import 'package:flutter/material.dart';
import 'package:travile/services/auth.dart';
import 'package:travile/shared/constants.dart';
import 'package:travile/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: pricol,
              elevation: 0.0,
              title: const Text('Sign in to Travile'),
              actions: <Widget>[
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: secol,
                  ),
                  icon: const Icon(Icons.person),
                  label: const Text('Register'),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'email'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'password'),
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: pricol,
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Could not sign in with those credentials';
                                });
                              }
                            }
                          }),
                      const SizedBox(height: 12.0),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     primary: Colors.pink[400],
                      //   ),
                      //   child: const Text(
                      //     'Sign In with Google',
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      //   onPressed: () async {
                      //     setState(() {
                      //       loading = true;
                      //     });
                      //     dynamic result = await _auth.signInWithGoogle();
                      //     if(result == null) {
                      //       setState(() {
                      //         loading = false;
                      //         error = 'Could not sign in with Google';
                      //       });
                      //     }
                      //   }
                      // ),
                      // IconButton(
                      //   onPressed: () async {
                      //     setState(() {
                      //       loading = true;
                      //     });
                      //     dynamic result = await _auth.signInWithGoogle();
                      //     if(result == null) {
                      //       setState(() {
                      //         loading = false;
                      //         error = 'Could not sign in with Google';
                      //       });
                      //     }
                      //   },
                      //   icon: Image.asset('lib/shared/sign_in_google.png', height: 60, width: 200),
                      // ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.signInWithGoogle();
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Could not sign in with Google';
                            });
                          }
                        },
                        child: Container(
                          width: 200.0,
                          height: 50.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: AssetImage(
                                'lib/shared/sign_in_google.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        error,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
