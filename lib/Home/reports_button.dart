import 'package:flutter/material.dart';

class ReportsButton extends StatelessWidget {
  const ReportsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ReportsButtonSingle(
            title: "Generated Coupons",
            onPressed: () {
              Navigator.pushNamed(context, 'report/generated_coupons');
            },
          ),
          ReportsButtonSingle(
            title: "Users Stats",
            onPressed: () {
              Navigator.pushNamed(context, 'report/users_coupons');
            },
          )
        ],
      ),
    );
  }
}

class ReportsButtonSingle extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const ReportsButtonSingle(
      {required this.title, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context)
                    .colorScheme
                    .tertiaryContainer
                    .withOpacity(.5),
                offset: Offset(1, 1),
                blurRadius: 10,
              ),
              BoxShadow(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                offset: Offset(-1, -1),
                blurRadius: 10,
              )
            ],
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.all(Radius.circular(70))),
        child: Text(title),
      ),
    );
  }
}
