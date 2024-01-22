import 'package:apk1/screens/novel/main-novel.dart';
import 'package:apk1/widget/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showSignUpSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sign Up Success!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  bool _validateInputs() {
    if (_userNameTextController.text.isEmpty ||
        _emailTextController.text.isEmpty ||
        _passwordTextController.text.isEmpty) {
      _showErrorSnackbar('Anda harus mengisi semua form terlebih dahulu.');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.lightBlue,
              Colors.blueAccent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter UserName",
                  Icons.person_outline,
                  false,
                  _userNameTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Email Id",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outlined,
                  true,
                  _passwordTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () async {
                  if (_validateInputs()) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      );

                      _showSignUpSuccessSnackbar(); // Show sign-up success Snackbar
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainNovelScreen(),
                        ),
                      );
                    } catch (error) {
                      String errorMessage = "Error during sign up";

                      if (error is FirebaseAuthException) {
                        switch (error.code) {
                          case 'email-already-in-use':
                            errorMessage = "Email is already in use";
                            break;
                          case 'weak-password':
                            errorMessage = "Password is too weak";
                            break;
                          case 'invalid-email':
                            errorMessage = "Invalid email address";
                            break;
                          default:
                            errorMessage =
                                "An error occurred during sign up";
                        }
                      }

                      _showErrorSnackbar(errorMessage);
                    }
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
