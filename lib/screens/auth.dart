

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = true; // to toggle b/w login and signup
  var _enteredEmail = '';
  var _enteredPassword = '';


   void _submit () async // will be triggered whenever the elevated button is pressed
   {
     //trigger validators and ensure that inputs are saved
    final isValid = _form.currentState!.validate(); // will be set not null

    if(!isValid) { // if i/p is not valid then simply return
      return;
    }

    _form.currentState!.save();
try{
    if(_isLogin) {
      //log users in
      //logic to log user in

        final userCredentials = _firebase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

    }

    else {
      //create a new user account using firebase

      final userCredentials = await _firebase.createUserWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredPassword,
      );

    }
} on FirebaseAuthException catch(error) {
          if(error.code == 'email-already-in-use') {
            //
          }
          if(!mounted) return; // if user navigates away or screen crashed during await, it would not give error using context

          ScaffoldMessenger.of(context).clearSnackBars(); //clears existing snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message ?? 'Authentication failed.'),
            ),
         );
     }


   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                margin: EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),

              Card(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please enter a valid email address.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredEmail = value!;
                              },

                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Password',
                              ),
                              obscureText: true,
                              validator: (value){
                                if(value == null || value.trim().length < 6){
                                  return 'Password must be at least 6 characters long.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredPassword = value!;
                              },
                            ),
                            SizedBox(
                              height: 12,
                            ),

                             ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                               ),
                               onPressed: _submit,
                               child:  Text(_isLogin ? 'Login' : 'Signup'),

                             ),
                              
                              TextButton(
                                  onPressed: () {
                                    //for switching modes we need setstate
                                    setState(() {
                                      // _isLogin = _isLogin ? false : true;
                                      _isLogin = !_isLogin;
                                    });
                                  },
                                  child: Text(_isLogin? 'Create an account' : 'I already have an account'),
                              ),
                          ],
                        ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
