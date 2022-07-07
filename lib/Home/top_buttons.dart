import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius:
                const BorderRadius.only(bottomRight: Radius.circular(70))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DashboardTopActionButton(
                      buttonName: "Generate",
                      icon: Icon(
                        Icons.qr_code,
                        size: 40,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'coupon/generate');
                      },
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  DashboardTopActionButton(
                    buttonName: "Request",
                    icon: Icon(
                      Icons.add_card,
                      size: 40,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'coupon/request');
                    },
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  DashboardTopActionButton(
                    buttonName: "Release",
                    icon: Icon(
                      Icons.remove_from_queue_sharp,
                      size: 40,
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'coupon/release');
                    },
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                  ),
                  DashboardTopActionButton(
                    buttonName: "Transfer",
                    icon: Icon(
                      Icons.move_up,
                      size: 40,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'coupon/transfer_select');
                    },
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardTopActionButton extends StatelessWidget {
  final Color color;
  final Icon icon;
  final String buttonName;
  final void Function()? onPressed;
  const DashboardTopActionButton(
      {Key? key,
      required this.color,
      required this.buttonName,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          height: 60,
          width: 70,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                elevation: 10,
                primary: color),
            onPressed: onPressed,
            // label: Text("Generate"),
            child: icon,
          ),
        ),
        Text(
          buttonName,
          style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.background),
        )
      ]),
    );
  }
}
