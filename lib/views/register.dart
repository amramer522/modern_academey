import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modern_app_flutter/core/design/app_button.dart';
import 'package:modern_app_flutter/core/logic/helper_methods.dart';
import 'package:modern_app_flutter/views/home.dart';

import '../core/design/app_input.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24).copyWith(
          top: 64,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Create New Account",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
            ),
            SizedBox(height: 8),
            Text(
              "Please fill your data below.",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff7E7E7E)),
            ),
            SizedBox(height: 24),
            AppInput(
              text: "Your Name",
              controller: nameController,
            ),
            AppInput(
              text: "Email Address",
              controller: emailController,
            ),
            AppInput(
              text: "Phone Number",
              controller: phoneController,
            ),
            AppInput(
              text: "Password",
              isPassword: true,
              controller: passwordController,
            ),
            AppButton(
              isLoading: isLoading,
              onPressed: () async {
                isLoading = true;
                setState(() {});
                print(nameController.text);
                print(emailController.text);
                print(phoneController.text);
                print(passwordController.text);

                try {
                  final user = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  await FirebaseDatabase.instance
                      .ref()
                      .child("users")
                      .child("${user.user!.uid}")
                      .set({
                    "name": nameController.text,
                    "email": emailController.text,
                    "phone": phoneController.text,
                    "password": passwordController.text,
                  });
                  showMessage("Success", isSuccess: true);
                  navigateTo(HomeView(
                    id: user.user!.uid,
                  ));
                } on FirebaseAuthException catch (ex) {
                  showMessage(ex.message ?? "");
                }

                isLoading = false;
                setState(() {});
              },
              text: "Create Account",
            ),
          ],
        ),
      ),
    );
  }
}
