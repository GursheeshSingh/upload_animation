import 'dart:math';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';

void main() {
  timeDilation = 2.0;
  runApp(MyApp());
}

Color kYellow = Color(0xFFFAE3B9);
Color kOrange = Color(0xFFF59362);
Color kGray = Color(0xFF2A3448);

Color kTextGray = Color(0xFF323440);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kYellow,
        child: Center(
          child: StaggerAnimation(
            controller: _controller,
          ),
        ),
      ),
    );
  }
}

class StaggerAnimation extends StatefulWidget {
  final AnimationController controller;

  StaggerAnimation({Key key, this.controller});

  @override
  _StaggerAnimationState createState() => _StaggerAnimationState();
}

class _StaggerAnimationState extends State<StaggerAnimation> {
  Animation<double> heightAnimation;
  Animation<double> marginAnimation;
  Animation<double> widthAnimation;
  Animation<double> widthAnimation2;
  Animation<double> widthAnimation3;
  Animation<double> heightAnimation2;
  Animation<Offset> offsetAnimation;
  Animation<Offset> offsetAnimation2;
  Animation<double> opacityAnimation;
  Animation<double> marginAnimation2;
  Animation<double> sizeAnimation;

  double _width;

  @override
  void initState() {
    super.initState();

    _width = 60;

    widthAnimation3 = Tween<double>(
      begin: 0,
      end: 300,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(
          0.5,
          0.8,
          curve: Curves.ease,
        ),
      ),
    );

    heightAnimation2 = Tween<double>(
      begin: 5.0,
      end: 60.0,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(
          0.8,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    heightAnimation = Tween<double>(
      begin: 50.0,
      end: 60.0,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(
          0.0,
          0.25,
          curve: Curves.ease,
        ),
      ),
    );

    marginAnimation = Tween<double>(
      begin: 5,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(
          0.0,
          0.25,
          curve: Curves.ease,
        ),
      ),
    );

    widthAnimation = Tween<double>(
      begin: 60.0,
      end: 75.0,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(
          0.0,
          0.25,
          curve: Curves.ease,
        ),
      ),
    )..addListener(() {
        if (widget.controller.value <= 0.25) {
          setState(() => _width = widthAnimation.value);
        }
//        print('At ${widget.controller.value} = ' +
//            widthAnimation.value.toString());
      });

    widthAnimation2 = Tween(
      begin: 75.0,
      end: 300.0,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(0.25, 0.45, curve: Curves.ease),
      ),
    )..addListener(() {
        if (widget.controller.value >= 0.25 &&
            widget.controller.value <= 0.45) {
//          print('At ${widget.controller.value} = ' +
//              widthAnimation2.value.toString());
          setState(() {
            _width = widthAnimation2.value;
          });
        }
      });

    offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -0.8),
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(
          0.25,
          0.35,
          curve: Curves.ease,
        ),
      ),
    );

    offsetAnimation2 = Tween<Offset>(
      begin: const Offset(0.0, 2.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(
          0.35,
          0.50,
          curve: Curves.ease,
        ),
      ),
    );

    opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(
          0.25,
          0.35,
          curve: Curves.ease,
        ),
      ),
    );

    marginAnimation2 = Tween<double>(
      begin: 10.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(
          0.8,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    sizeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(
          0.8,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) => Container(
        height: 60,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: SlideTransition(
                  position: offsetAnimation,
                  child: Opacity(
                    opacity: opacityAnimation.value,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 8,
                        ),
                        Transform.rotate(
                          angle: pi / 2,
                          child: Icon(
                            Icons.attachment,
                            color: kTextGray,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Document.pdf',
                          style: TextStyle(
                            color: kTextGray,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    widget.controller.forward();
                  },
                  child: Container(
                    height: heightAnimation.value,
                    width: _width,
                    decoration: BoxDecoration(
                      color: kOrange,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    margin: EdgeInsets.only(
                      right: marginAnimation.value,
                    ),
                    child: SlideTransition(
                      position: offsetAnimation,
                      child: Opacity(
                        opacity: opacityAnimation.value,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin:
                                EdgeInsets.all(6 + (5 - marginAnimation.value)),
                            child: Text(
                              'Upload',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SlideTransition(
                  position: offsetAnimation2,
                  child: Text(
                    'Uploading...',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: heightAnimation2.value,
                  width: widthAnimation3.value,
                  decoration: BoxDecoration(
                    color: kGray,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: marginAnimation2.value),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Completed',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
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
        ),
      ),
    );
  }
}
