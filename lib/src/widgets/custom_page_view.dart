import 'package:flutter/material.dart';

import '../view_utils.dart';

const SCALE_FRACTION = 0.3;
const FULL_SCALE = 1.0;

class CustomPageView extends StatefulWidget {
  final List<Widget> children;
  final double height;
  final Function(int index) onPageChanged;
  final Function(double page) onPageScrolled;

  CustomPageView({
    @required this.children,
    @required this.height,
    this.onPageChanged,
    this.onPageScrolled,
  });

  @override
  State<StatefulWidget> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  double _page;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.9, keepPage: true);
    _page = 0;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: ScrollConfiguration(
        behavior: RemoveDefaultScrollGlowBehavior(),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollUpdateNotification) {
              setState(() {
                _page = _controller.page;
              });
              widget.onPageScrolled(_page);
            }
          },
          child: PageView.builder(
            physics: BouncingScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {
              widget.onPageChanged(index);
            },
            itemCount: widget.children.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimatedBuilder(
                animation: _controller,
                child: widget.children[index],
                builder: (BuildContext context, child) {
                  final diffPosition = _page - index;
                  double normalizedDistortion = (FULL_SCALE - (diffPosition.abs() * SCALE_FRACTION)).clamp(0.0, 1.0);

                  final double distortionValue = Curves.ease.transform(normalizedDistortion);
                  return Center(child: SizedBox(height: distortionValue * widget.height, child: child));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
