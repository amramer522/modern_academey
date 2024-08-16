import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final bool isLoading;

  const AppButton({
    super.key,
    this.text = "",
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if(isLoading)
      {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    return FilledButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
