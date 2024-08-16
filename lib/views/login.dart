import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modern_app_flutter/core/design/app_button.dart';
import 'package:modern_app_flutter/core/logic/helper_methods.dart';
import 'package:modern_app_flutter/views/home.dart';
import 'package:modern_app_flutter/views/register.dart';

import '../core/design/app_image.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24).copyWith(
            top: 64,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppImage(
                "logo.png",
                width: 161,
                height: 150,
              ),
              SizedBox(height: 16),
              Text(
                "My Market",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontFamily: "NewRocker"),
              ),
              SizedBox(height: 64),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email Address"),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
              ),
              SizedBox(height: 8),
              Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                      onPressed: () {
                        navigateTo(RegisterView());
                      },
                      child: Text("Create New Account"))),
              SizedBox(height: 24),
              AppButton(
                  isLoading: isLoading,
                  onPressed: () async {
                    isLoading = true;
                    setState(() {});
                    print(emailController.text);
                    print(passwordController.text);
                    try {
                      final user = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      showMessage("Success you id is ${user.user?.uid}",
                          isSuccess: true);
                      print(user);
                      navigateTo(HomeView(id: user.user!.uid,));
                    } on FirebaseAuthException catch (ex) {
                      print(ex.code);
                      print(ex.message);
                      print(ex.email);
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        showMessage("Please Fill Your Data");
                      } else if (ex.code == "invalid-email") {
                        showMessage("The Email is Wrong Formatted");
                      } else if (ex.code == "invalid-credential") {
                        showMessage("Wrong Data Try Again");
                      } else {
                        showMessage(ex.message ?? "");
                      }
                    }
                    isLoading = false;
                    setState(() {});
                  },
                  text: "Login"),
            ],
          ),
        ),
      ),
    );
  }
}
