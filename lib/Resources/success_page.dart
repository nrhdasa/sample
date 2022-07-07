import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/success.json"),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 5, end: 1),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInCirc,
            onEnd: () {
              Future.delayed(Duration(seconds: 1)).then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (route) => false);
              });
            },
            builder: (context, double val, child) {
              return Transform.scale(
                scale: val,
                child: child,
              );
            },
            child: Text(
              "Success!",
              style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
        ],
      )),
    );
  }
}
