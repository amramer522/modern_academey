import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modern_app_flutter/core/logic/helper_methods.dart';
import 'package:modern_app_flutter/views/login.dart';

import '../core/design/app_image.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  double sliderValue = 10;

  final list = [
    _Model(
        title: "Welcome to\nMy Market App",
        desc:
            "Discover the easiest way to manage your products, track inventory, and keep an eye on your sales invoices all in one place.",
        image: "on_boarding1.jpg"),
    _Model(
        title: "Sell Products\nEffortlessly",
        desc:
            "List your products, set prices, and start selling to your customers in just a few taps.",
        image: "on_boarding2.jpg"),
    _Model(
        title: "Track Your Inventory",
        desc:
            "Keep track of your stock levels in real-time. Know exactly how many products you have at any moment.",
        image: "on_boarding3.jpg"),
  ];

  int currentPage = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .6,
            child: PageView.builder(
              controller: pageController,
              itemCount: list.length,
              onPageChanged: (value) {
                currentPage = value;
                setState(() {});
              },
              itemBuilder: (context, index) => AppImage(
                list[index].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              list.length,
              (index) => Padding(
                padding: EdgeInsetsDirectional.only(end: 8),
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: currentPage == index
                      ? Theme.of(context).primaryColor
                      : Color(0xffD9D9D9),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                list[currentPage].title,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                list[currentPage].desc,
                style: TextStyle(fontSize: 18, color: Color(0xff7E7E7E)),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                if (currentPage != list.length - 1)
                  TextButton(
                    onPressed: () {
                      navigateTo(LoginView());
                    },
                    child: Text("Skip"),
                  ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(currentPage==list.length-1)
                      {
                        navigateTo(LoginView());
                      }else
                        {
                          pageController.nextPage(
                            duration: Duration(milliseconds: 1200),
                            curve: Curves.bounceInOut,
                          );
                        }

                  },
                  child: AppImage("arrow_forward.svg"),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}

class _Model {
  final String image, title, desc;

  _Model({
    required this.title,
    required this.desc,
    required this.image,
  });
}
