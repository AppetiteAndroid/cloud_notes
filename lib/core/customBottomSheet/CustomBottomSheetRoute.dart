// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'CustomBottomSheetPage.dart';

class CustomBottomSheetRoute<T> extends PageRoute<T> {
  CustomBottomSheetRoute({
    required this.builder,
    required this.isDraggable,
    this.borderRadius,
    this.maxHeight,
    this.color,
    this.isSingleChild = false,
    this.isListView = false,
    this.title,
    this.addTongue,
  }) : super();

  final Widget Function(BuildContext context, ScrollController scrollController) builder;
  final bool isDraggable;
  final BorderRadius? borderRadius;
  final double? maxHeight;
  final Color? color;
  final bool isSingleChild;
  final bool isListView;
  final Widget? title;
  final bool? addTongue;

  @override
  Color? get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return CustomBottomSheetPage(
      builder: builder,
      isDraggable: isDraggable,
      maxHeight: maxHeight,
      borderRadius: borderRadius,
      color: color,
      isSingleChild: isSingleChild,
      isListView: isListView,
      addTongue: addTongue,
      title: title,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    var begin = const Offset(0, 1);
    var end = Offset.zero;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeOut));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}
