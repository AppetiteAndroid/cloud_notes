// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'CustomBottomSheetRoute.dart';

class CustomBottomSheetPage extends StatefulWidget {
  const CustomBottomSheetPage({
    Key? key,
    required this.builder,
    this.isDraggable = false,
    this.borderRadius,
    this.maxHeight,
    this.color,
    required this.isSingleChild,
    required this.isListView,
    this.title,
    this.addTongue = true,
  }) : super(key: key);

  @override
  State<CustomBottomSheetPage> createState() => _CustomBottomSheetPageState();
  final Widget Function(BuildContext context, ScrollController scrollController) builder;
  final bool isDraggable;
  final BorderRadius? borderRadius;
  final double? maxHeight;
  final Color? color;
  final bool isSingleChild;
  final bool isListView;
  final Widget? title;
  final bool? addTongue;
}

class _CustomBottomSheetPageState extends State<CustomBottomSheetPage> with TickerProviderStateMixin {
  late AnimationController _animationController;

  final ScrollController _scrollController = ScrollController();

  final GlobalKey keyForHeight = GlobalKey();

  double childHeight = 0;

  double drag = 0;

  double dX = 0;
  double dY = 0;

  bool isDragging = false;

  final VelocityTracker _vt = VelocityTracker.withKind(PointerDeviceKind.touch);

  bool _scrollingEnabled = false;
  final bool _isScrolling = false;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animationController.animateTo(0);
    _scrollController.addListener(() {
      if (!_scrollingEnabled) _scrollController.jumpTo(0);
    });
    WidgetsBinding.instance.addPostFrameCallback(getSizeOfChild);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void getSizeOfChild(_) {
    final RenderBox renderBoxRed = keyForHeight.currentContext?.findRenderObject() as RenderBox;
    final sizeOfChild = renderBoxRed.size;
    childHeight = sizeOfChild.height;
  }

  void _onDragUpdate(double dy) {
    if (_animationController.value == 0 && _scrollController.hasClients && _scrollController.offset <= 0) {
      if (dy < 0) {
        _scrollingEnabled = true;
      } else {
        drag = 0;
        _scrollingEnabled = false;
      }
    }
    if (!_scrollingEnabled) {
      isDragging = true;
      drag = (drag + dy).clamp(0, childHeight);
      _animationController.animateTo((drag / childHeight).clamp(0, 1), duration: const Duration(milliseconds: 0));
    }
    // Fimber.withTag("update", (log) => log.d("$dy ${_animationController.value} ${_scrollController.hasClients} ${_scrollController.offset} $_interactToScroll $_scrollingEnabled $isDragging"));

    if (_scrollingEnabled && _animationController.value == 0 && _scrollController.hasClients && isDragging) {
      drag += dy;
      _scrollController.jumpTo(-drag);
    }
  }

  void _onDragEnd(Velocity v) {
    isDragging = false;
    if (_animationController.isAnimating) return;
    if (_animationController.value == 0 && _scrollingEnabled) return;

    if (v.pixelsPerSecond.dy / 4 <= childHeight / 2) {
      if (drag >= childHeight / 2) {
        drag = childHeight;
        _animationController.animateTo(1, duration: const Duration(milliseconds: 200));
        Navigator.of(context).pop();
      } else {
        _animationController.animateTo(0, duration: const Duration(milliseconds: 150));
        drag = 0;
      }
    } else {
      drag = childHeight;
      _animationController.animateTo(1);
      Navigator.of(context).pop();
    }
  }

  Widget _gestureHandler({required Widget child}) {
    if (!widget.isDraggable) return child;

    // if (!_scrollController.hasClients) {
    //   return GestureDetector(
    //     onVerticalDragUpdate: (details) => _onDragUpdate(details.delta.dy),
    //     onVerticalDragEnd: (details) => _onDragEnd(details.velocity),
    //     child: child,
    //   );
    // }

    return Listener(
      onPointerDown: (PointerDownEvent p) {
        _vt.addPosition(p.timeStamp, p.position);
        dY = p.position.dy;
        dX = p.position.dx;
      },
      onPointerMove: (PointerMoveEvent p) {
        _vt.addPosition(p.timeStamp, p.position);
        if ((dY - p.position.dy).abs() > (dX - p.position.dx).abs()) {
          _onDragUpdate(p.delta.dy);
        }
      },
      onPointerUp: (PointerUpEvent p) => _onDragEnd(_vt.getVelocity()),
      child: child,
    );
  }

  Widget _getChildWidget({required double paddingView}) {
    return ConstrainedBox(
      key: keyForHeight,
      constraints: BoxConstraints(
        maxHeight: (widget.maxHeight ?? MediaQuery.of(context).size.height) - paddingView,
      ),
      child: widget.builder(context, _scrollController),
    );
  }

  @override
  Widget build(BuildContext context) {
    var paddingView = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SizedBox.expand(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          _gestureHandler(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    bottom: false,
                    child: Container(
                      transform: Matrix4.translationValues(0, _animationController.value * childHeight, 0),
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: widget.borderRadius ??
                            const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                      ),
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                      clipBehavior: Clip.hardEdge,
                      child: (widget.addTongue == true) || (widget.title != null)
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget.addTongue == true) ...[
                                  const SizedBox(height: 16),
                                  Container(
                                    width: 48,
                                    height: 4,
                                    decoration: BoxDecoration(color: const Color(0xff9FAAAE), borderRadius: BorderRadius.circular(100)),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                                if (widget.title != null) ...[
                                  widget.title!,
                                  const SizedBox(height: 16),
                                ],
                                _getChildWidget(
                                    paddingView: (MediaQuery.of(context).padding.top +
                                        (widget.title != null ? 40 : 0) +
                                        (widget.addTongue != null ? 44 : 0) +
                                        paddingView +
                                        MediaQuery.of(context).padding.bottom))
                              ],
                            )
                          : _getChildWidget(paddingView: paddingView),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<T?> showCustomBottomSheet<T>({
  required Widget Function(BuildContext context, ScrollController scrollController) builder,
  required BuildContext context,
  bool isDraggable = true,
  BorderRadius? borderRadius,
  double? maxHeight,
  Color? color,
  Widget? title,
  bool? addTongue = true,
}) {
  return Navigator.of(context)
      .push<T>(CustomBottomSheetRoute(builder: builder, isDraggable: isDraggable, borderRadius: borderRadius, maxHeight: maxHeight, color: color, addTongue: addTongue, title: title));
}

Future<T?> showSingleChildBottomSheet<T>(
    {required Widget Function(BuildContext context, ScrollController scrollController) builder,
    required BuildContext context,
    bool isDraggable = true,
    BorderRadius? borderRadius,
    double? maxHeight,
    Color? color}) {
  return Navigator.of(context).push<T>(CustomBottomSheetRoute(builder: builder, isDraggable: isDraggable, borderRadius: borderRadius, maxHeight: maxHeight, color: color));
}

Future<T?> showListViewBottomSheet<T>(
    {required Widget Function(BuildContext context, ScrollController scrollController) builder,
    required BuildContext context,
    bool isDraggable = true,
    BorderRadius? borderRadius,
    double? maxHeight,
    Color? color}) {
  return Navigator.of(context).push<T>(CustomBottomSheetRoute(builder: builder, isDraggable: isDraggable, borderRadius: borderRadius, maxHeight: maxHeight, color: color));
}
