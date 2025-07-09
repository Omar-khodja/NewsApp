import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      child: Text("News", style: Theme.of(context).textTheme.titleLarge),
      builder: (BuildContext context, value, child) {
        return Padding(
          padding: EdgeInsetsGeometry.only(top: value * 20),
          child: child,
        );
      },
    );
  }
}
