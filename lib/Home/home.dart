import 'package:flutter/material.dart';
import 'package:sample/Home/reports_button.dart';
import '../Auth Cubit/auth_widget.dart';
import '../Connection/auth.dart';
import '../Internet Cubit/internet_widget.dart';
import 'operations.dart';
import 'slot_details.dart';
import 'top_buttons.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternetWidget(
        child: AuthWidget(
      child: FutureBuilder(
        future: getFullName(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: AppBar(
                toolbarHeight: 100,
                backgroundColor: Theme.of(context).colorScheme.background,
                title: SizedBox(
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SelectableText(
                        "Welcome ${snapshot.data}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (Color circleColor in [
                              Colors.amber,
                              Colors.blue,
                              Colors.red
                            ])
                              Container(
                                height: 10,
                                width: 20,
                                // color: Colors.black,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: circleColor,
                                  // borderRadius:
                                  //     BorderRadius.all(Radius.circular(100))
                                ),
                              )
                          ])
                    ],
                  ),
                ),
                shadowColor: Theme.of(context).colorScheme.shadow,
                actions: [
                  IconButton(
                      onPressed: () {
                        Auth().logout();
                      },
                      icon: Icon(Icons.logout,
                          color: Theme.of(context).colorScheme.errorContainer))
                ],
              ),
              body: Container(
                //
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const TopButtons(),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      const ReportsButton(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Today's Summary",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).colorScheme.onBackground)),
                      const SizedBox(
                        height: 10,
                      ),
                      const slotsWidget()
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    ));
  }
}

// ignore: camel_case_types
class slotsWidget extends StatefulWidget {
  const slotsWidget({Key? key}) : super(key: key);

  @override
  State<slotsWidget> createState() => _slotsWidgetState();
}

// ignore: camel_case_types
class _slotsWidgetState extends State<slotsWidget>
    with SingleTickerProviderStateMixin {
  final List<bool> _isSelectedSlot = [true, false, false];
  final List<bool> _isSelectedCouponType = [true, false];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: ToggleButtons(
              borderWidth: 4,
              onPressed: (index) {
                setState(() {
                  for (int i = 0; i < _isSelectedCouponType.length; i++) {
                    if (index == i) {
                      _isSelectedCouponType[i] = true;
                    } else {
                      _isSelectedCouponType[i] = false;
                    }
                  }
                });
              },
              fillColor: Theme.of(context).colorScheme.background,
              highlightColor: Colors.redAccent,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              //focusColor: Colors.blue.withOpacity(.5),
              //focusColor: Colors.black,
              direction: Axis.horizontal,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              isSelected: _isSelectedCouponType,
              children: [
                for (String slot in [
                  "Silver",
                  "Gold",
                ])
                  Padding(
                    padding: const EdgeInsets.all(14.8),
                    child: Text(
                      slot,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
              ],
            ),
          ),
        ),
        FutureBuilder(
            future: getDashboardData(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: ToggleButtons(
                            borderWidth: 1,
                            onPressed: (index) {
                              setState(() {
                                for (int i = 0;
                                    i < _isSelectedSlot.length;
                                    i++) {
                                  // print("i");
                                  // print(i);
                                  // print("index");
                                  // print(index);
                                  if (index == i) {
                                    _isSelectedSlot[i] = true;
                                  } else {
                                    _isSelectedSlot[i] = false;
                                  }
                                }
                              });
                            },
                            fillColor: Theme.of(context).colorScheme.background,
                            highlightColor: Colors.redAccent,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            //focusColor: Colors.blue.withOpacity(.5),
                            //focusColor: Colors.black,
                            direction: Axis.horizontal,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            isSelected: _isSelectedSlot,
                            children: [
                              for (String slot in [
                                "Morning",
                                "Afternoon",
                                "Evening"
                              ])
                                Padding(
                                  padding: const EdgeInsets.all(14.8),
                                  child: Text(
                                    slot,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SlotDetails(
                      data: {
                        'data': snapshot.data ?? {},
                        'slot': _isSelectedSlot,
                        'type': _isSelectedCouponType
                      },
                    )
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ],
    );
  }
}
