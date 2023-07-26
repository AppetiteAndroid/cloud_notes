import 'package:flutter/material.dart';

class AppUnfocus extends StatelessWidget {
  final Widget child;
  const AppUnfocus({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: child, onTap: () => FocusScope.of(context).unfocus());
  }
}
