import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample/Resources/buttons.dart';
import 'package:sample/Resources/common.dart';

import '../Auth Cubit/auth_widget.dart';
import '../Internet Cubit/internet_widget.dart';
import 'operations.dart';

class TransferSelect extends StatefulWidget {
  const TransferSelect({Key? key}) : super(key: key);

  @override
  State<TransferSelect> createState() => _TransferSelectState();
}

class _TransferSelectState extends State<TransferSelect> {
  List<dynamic> users = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InternetWidget(
      child: AuthWidget(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(.8),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(90),
                    topLeft: Radius.circular(90),
                    bottomLeft: Radius.circular(200),
                    topRight: Radius.circular(200),
                  )),
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20, right: 25),
                child: Text(
                  "Select a user to transfer",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            shadowColor: Theme.of(context).colorScheme.shadow,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: FutureBuilder<List<dynamic>>(
              future: getPrasadamCPNUsers(context),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  users = snapshot.data!;
                  return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, ind) {
                        return Container(
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide()),
                          ),
                          child: ListTile(
                            title: Text(users[ind]['full_name']),
                            subtitle: Text(users[ind]['name']),
                            leading: Icon(Icons.person),
                            onTap: () {
                              Navigator.pushNamed(context, 'coupon/transfer',
                                  arguments: {"user": users[ind]});
                            },
                            hoverColor: Theme.of(context).colorScheme.secondary,
                            tileColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            textColor: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                        );
                      });
                } else {
                  return const CircularProgressIndicator();
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}
