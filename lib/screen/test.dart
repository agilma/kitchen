import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: FadeTransitionExample(),
    );
  }
}

class FadeTransitionExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Fade();
}

class _Fade extends State<FadeTransitionExample> with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? _animationValue;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2),);
    _animationValue = Tween<double>(begin: 0.0, end: 0.5).animate(animationController!);

    animationController!.addStatusListener((status){
      if(status == AnimationStatus.completed){
        animationController!.reverse();
      }
      else if(status == AnimationStatus.dismissed){
        animationController!.forward();
      }
    });
    animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FadeTransition(
            opacity: _animationValue!,
            child: Container(
              color: Colors.blue,
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}