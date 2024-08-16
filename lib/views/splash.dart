import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modern_app_flutter/core/logic/helper_methods.dart';
import 'package:modern_app_flutter/views/home.dart';
import 'package:modern_app_flutter/views/on_boarding.dart';

import '../core/design/app_image.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () {
        if (FirebaseAuth.instance.currentUser != null) {
          navigateTo(HomeView(id: "JxKcaGkwiBWIQzle89oVYGeu7mY2",));
        } else {
          navigateTo(OnBoardingView());
        }
      },
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Swing(
                child: AppImage(
              "logo.png",
              width: 161,
              height: 150,
            )),
            SizedBox(
              height: 16,
            ),
            Text(
              "My Market",
              style: TextStyle(fontSize: 32, fontFamily: "NewRocker"),
            )
          ],
        ),
      ),
    );
  }
}
