import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final double width;
  final double height;

  final Animation<double> controller;
  final Animation<Offset> translationOffset;
  final Animation<Offset> slideInOffset;
  final Animation<double> rotationAngle;
  final Animation<double> containerWidth;
  final Animation<double> listOpacity;
  final Animation<double> lineSizeDivisionFactor;
  final void Function() onTap;
  final String text = "CHALLENGE1";
  Menu({
    super.key,
    required this.controller,
    required this.width,
    required this.height,
    required this.onTap,
  })  : translationOffset = Tween<Offset>(
          begin: Offset(0, height / 10),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.4, curve: Curves.ease),
          ),
        ),
        slideInOffset = Tween<Offset>(
          begin: Offset(0, height / 5),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 1.0, curve: Curves.ease),
          ),
        ),
        listOpacity = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 1.0, curve: Curves.ease),
          ),
        ),
        rotationAngle = Tween<double>(
          begin: 0,
          end: 0.8,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 1, curve: Curves.ease),
          ),
        ),
        lineSizeDivisionFactor = Tween<double>(
          begin: 2,
          end: 3,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.4, 0.6, curve: Curves.ease),
          ),
        ),
        containerWidth = Tween<double>(begin: height, end: width).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.4, 0.6, curve: Curves.ease),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    constraints: BoxConstraints(minWidth: height),
                    width: containerWidth.value,
                    height: height,
                    decoration: BoxDecoration(
                      color: Colors.black87.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(height),
                    ),
                    child: Transform.translate(
                      offset: slideInOffset.value,
                      child: Row(
                        children: [
                          SizedBox(
                            height: height,
                            width: height,
                          ),
                          Expanded(
                            child: Opacity(
                              opacity: listOpacity.value,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                        top: height * 0.15,
                                        bottom: height * 0.15),
                                    height: height * 0.7,
                                    width: height * 0.7,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius:
                                          BorderRadius.circular(height),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {},
                                        borderRadius:
                                            BorderRadius.circular(height * 0.7),
                                        splashColor: Colors.amber,
                                        child: Center(
                                          child: Text(
                                            text[index],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: height,
                    width: height,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(height)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          onTap();
                        },
                        borderRadius: BorderRadius.circular(height),
                        child: Center(
                          child: Stack(
                            children: [
                              Transform.translate(
                                offset: translationOffset.value,
                                child: Center(
                                  child: Transform.rotate(
                                    alignment: Alignment.topRight,
                                    angle: -rotationAngle.value,
                                    child: Container(
                                      height: height / 12,
                                      width:
                                          height / lineSizeDivisionFactor.value,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: -translationOffset.value,
                                child: Center(
                                  child: Transform.rotate(
                                    alignment: Alignment.bottomRight,
                                    angle: rotationAngle.value,
                                    child: Container(
                                      height: height / 12,
                                      width:
                                          height / lineSizeDivisionFactor.value,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}

class MenuAnimationDemo extends StatefulWidget {
  const MenuAnimationDemo({super.key});

  @override
  State<MenuAnimationDemo> createState() => _MenuAnimationDemoState();
}

class _MenuAnimationDemoState extends State<MenuAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    if (_controller.status == AnimationStatus.completed) {
      try {
        await _controller.reverse().orCancel;
      } on TickerCanceled {
        // the animation got canceled, probably because we were disposed
      }
    } else if (_controller.status == AnimationStatus.dismissed) {
      try {
        await _controller.forward().orCancel;
      } on TickerCanceled {
        // the animation got canceled, probably because we were disposed
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Menu(
      controller: _controller.view,
      width: 350,
      height: 60,
      onTap: () => _playAnimation(),
    );
  }
}
