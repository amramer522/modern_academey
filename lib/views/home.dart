import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modern_app_flutter/core/design/app_image.dart';
import 'package:modern_app_flutter/core/logic/helper_methods.dart';
import 'package:modern_app_flutter/views/login.dart';

import 'add_product.dart';

class HomeView extends StatefulWidget {
  final String id;

  const HomeView({super.key, required this.id});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? name;

  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance.ref().child("users").child("${widget.id}").get().then((value) {
      print(value.value);
      var data = value.value as Map;
      name = data["name"];
      setState(() {

      });
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: 24),
          child: AppImage(
            "logo.png",
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                navigateTo(LoginView());
              },
              icon: Icon(
                Icons.logout,
                color: Colors.red,
              )),
          GestureDetector(
              onTap: () {
                print("Hello");
              },
              child: AppImage("cart.svg")),
          SizedBox(width: 24),
        ],
        title: Text(
          "My Market ${name??""}",
          style: TextStyle(fontFamily: "NewRocker"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateTo(AddProductView());
        },
        child: AppImage("add.svg"),
      ),
      body: ListView.separated(
          padding: EdgeInsets.all(24),
          itemBuilder: (context, index) => _Item(
                index: index,
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
          itemCount: 3),
    );
  }
}

class _Item extends StatelessWidget {
  final int index;

  const _Item({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(AddProductView(
          isAdd: false,
        ));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            AppImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnMEc5W21EPWb4exgUHJHodhJfc8cK1E6MNQ&s",
              height: 95,
              radius: 16,
              width: 102,
              isClickable: index == 0 || index == 1,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product2",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Description " * 10,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).secondaryHeaderColor),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "75",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "EGY",
                      style: TextStyle(
                          fontSize: 10, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                FloatingActionButton(
                  mini: true,
                  heroTag: "$index",
                  onPressed: () {},
                  child: AppImage("add.svg"),
                )
              ],
            )
          ],
        ),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
          BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              blurStyle: BlurStyle.outer,
              color: Colors.black.withOpacity(.5))
        ]
                // color: Colors.green,
                ),
      ),
    );
  }
}
