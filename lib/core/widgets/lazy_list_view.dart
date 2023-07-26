import 'package:flutter/cupertino.dart';

class LazyListView extends StatelessWidget {
  final List<Widget> childrenBefore;
  final List<Widget> childrenAfter;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index) separatorBuilder;
  final ScrollController? controller;
  final EdgeInsets? padding;
  final EdgeInsets? paddingBefore;
  final bool shrinkWrap;
  final Axis scrollDirection;

  const LazyListView({
    Key? key,
    this.childrenBefore = const [],
    this.childrenAfter = const [],
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    this.controller,
    this.padding,
    this.paddingBefore,
    this.shrinkWrap = false,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => separatorBuilder(context, index),
      shrinkWrap: shrinkWrap,
      controller: controller,
      padding: padding ?? const EdgeInsets.only(bottom: 30.0),
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: itemCount + childrenBefore.length + childrenAfter.length,
      scrollDirection: scrollDirection,
      itemBuilder: (context, index) {
        if (index < childrenBefore.length) {
          return childrenBefore[index];
        } else if (index >= itemCount + childrenBefore.length) {
          return childrenAfter[index - itemCount - childrenBefore.length];
        }
        final int builderIndex = index - childrenBefore.length;

        return itemBuilder(context, builderIndex);
      },
    );
  }
}
