import 'package:flutter/material.dart';

class HKMGeneralButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  const HKMGeneralButton(
      {Key? key, required this.onPressed, required Widget this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 50),
          primary: Theme.of(context).colorScheme.onBackground,
          onPrimary: Theme.of(context).colorScheme.background,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),

          // textStyle: TextStyle(
          //   color: Theme.of(context).colorScheme.onPrimary,
          //   fontSize: Theme.of(context).textTheme.headline3
          // )
        ),
        onPressed: onPressed,
        child: child);
  }
}

class HKMIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Icon icon;
  const HKMIconButton({Key? key, required this.onPressed, required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        shape: const CircleBorder(),
      ),
      child: IconButton(
        iconSize: 50,
        onPressed: onPressed,
        icon: icon,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}

class HKMTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  const HKMTextButton({Key? key, required this.onPressed, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          minimumSize: const Size(100, 50),
          primary: Theme.of(context).colorScheme.onBackground,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),

          // textStyle: TextStyle(
          //   color: Theme.of(context).colorScheme.onPrimary,
          //   fontSize: Theme.of(context).textTheme.headline3
          // )
        ),
        onPressed: onPressed,
        child: child);
  }
}
