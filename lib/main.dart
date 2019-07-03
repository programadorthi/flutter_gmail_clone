import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gmail_clone/mail_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Gmail',
      theme: ThemeData.light().copyWith(
        accentColor: Colors.blue,
        primaryColor: Colors.white,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _statusBarColorTween;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _statusBarColorTween = ColorTween(
      begin: Colors.white70,
      end: Colors.white,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _statusBarColorTween,
      builder: (_, child) {
        return AnnotatedRegion(
          value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: _statusBarColorTween.value,
          ),
          child: MailList(
            animation: _controller,
            floating: _controller.status == AnimationStatus.dismissed,
            pinned: _controller.status == AnimationStatus.completed,
            animate: _animate,
          ),
        );
      },
    );
  }

  void _animate(bool reverse) {
    if (reverse && _controller.status != AnimationStatus.dismissed) {
      _controller.reverse();
      return;
    }

    if (_controller.status != AnimationStatus.completed) {
      _controller.forward();
    }
  }
}
