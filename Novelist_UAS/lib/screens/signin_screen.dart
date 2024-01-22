import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:apk1/screens/novel/main-novel.dart';
import 'package:apk1/screens/reset_password.dart';
import 'package:apk1/screens/signup_screen.dart';
import 'package:apk1/widget/reusable_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showLoginSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login Success!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Validate form fields
  bool _validateForm() {
    if (_emailTextController.text.isEmpty || _passwordTextController.text.isEmpty) {
      _showErrorSnackbar("Anda harus mengisi form login");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade700,
              Colors.blue.shade500,
              Colors.blue.shade300,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo1.png"),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField(
                  "Enter UserName",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outline,
                  true,
                  _passwordTextController,
                ),
                const SizedBox(
                  height: 5,
                ),
                forgetPassword(context),
                firebaseUIButton(context, "Sign In", _onSignInPressed),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

void _onSignInPressed() {
  if (_validateForm()) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: _emailTextController.text,
      password: _passwordTextController.text,
    )
        .then((value) {
      _showLoginSuccessSnackbar(); // Show login success Snackbar
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainNovelScreen()),
      );
    }).catchError((error) {
      String errorMessage = "Email atau Password yang anda masukkan salah";

      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'user-not-found':
            errorMessage = "Email yang anda masukkan tidak valid";
            break;
          case 'wrong-password':
            errorMessage = "Password yang anda masukkan salah";
            break;
          case 'invalid-email':
            errorMessage = "Format email yang anda masukkan tidak valid";
            break;
          
        }
      }

      _showErrorSnackbar(errorMessage);
    });
  }
}



  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?", style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPassword()),
        ),
      ),
    );
  }
}
