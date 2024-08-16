import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/logic/helper_methods.dart';
import 'firebase_options.dart';
import 'views/add_product.dart';
import 'views/home.dart';
import 'views/login.dart';
import 'views/on_boarding.dart';
import 'views/register.dart';
import 'views/splash.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const primaryColor = Color(0xffFCB836);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        secondaryHeaderColor: Color(0xff7E7E7E),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD9D9D9))
          )
        ),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: createMaterialColor(primaryColor),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
        ),
      ),
      home: RegisterView(),
    );
  }
}


// Alignment Widgets
/*
MaterialApp
Scaffold
SafeArea
Center
Transform.scale
Directionality
SizedBox
SingleChildScrollView
Column
Row
Wrap
Text
TextButton
Icon
IconButton
FilledButton
OutlinedButton
ElevatedButton
Image.network
Image.asset
Container
Drawer
AppBar
FloatingActionButton
TextField
TextFormField
Slider
CheckBox
CircleAvatar
ListTile
ListView
ListView.builder
PageView
PageView.builder
GridView
GridView.builder
Padding
Align
Spacer
Expanded
GestureDetector
InkWell
ClipRRect
Builder
Stack
CircularProgressIndicator
LinearProgressIndicator
CupertinoActivityIndicator

BottomNavigationBar
TabBar
TabBarView
Fleixable
RadioButton




 */
