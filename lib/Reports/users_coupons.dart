import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Auth Cubit/auth_widget.dart';
import '../Internet Cubit/internet_widget.dart';
import '../Resources/buttons.dart';
import 'operations.dart';

class UserCoupons extends StatefulWidget {
  const UserCoupons({Key? key}) : super(key: key);

  @override
  State<UserCoupons> createState() => _UserCouponsState();
}

class _UserCouponsState extends State<UserCoupons> {
  List<dynamic> users = [];
  DateTime _operationDate =
      DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  String _slot = "Morning";
  @override
  Widget build(BuildContext context) {
    return InternetWidget(
      child: AuthWidget(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 200,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.primary.withOpacity(.8),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(90),
                        topLeft: Radius.circular(90),
                        bottomLeft: Radius.circular(200),
                        topRight: Radius.circular(200),
                      )),
                  height: 70,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 20, right: 25),
                    child: Text(
                      "Users Coupons",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HKMTextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.calendar_today_outlined,
                              size: 20,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            DateFormat('EEEE, dd MMM').format(_operationDate),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        DateTime? datetime = await showDatePicker(
                          context: context,
                          initialDate: _operationDate,
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 30)),
                          lastDate: DateTime.now().add(const Duration(days: 7)),
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                        );
                        setState(() {
                          if (datetime != null) {
                            _operationDate = datetime;
                          }
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      child: DropdownButton<String>(
                          value: _slot,
                          focusColor: Colors.amber,
                          dropdownColor: Colors.amber,
                          items: ["Morning", "Afternoon", "Evening"].map((e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              _slot = val!;
                            });
                          }),
                    ),

                    // DropdownButtonFormField(
                    //   items: ["Morning", "Afternoon", "Evening"].map((e) {
                    //     return DropdownMenuItem<String>(
                    //       value: e,
                    //       child: Text(e),
                    //     );
                    //   }).toList(),
                    //   onChanged: (val) {},
                    // )
                  ],
                ),
              ],
            ),
            shadowColor: Theme.of(context).colorScheme.shadow,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: FutureBuilder<List<dynamic>>(
              future: getUserCoupons(context, _operationDate, _slot),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  users = snapshot.data!;
                  return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, ind) {
                        return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              border: const Border(bottom: BorderSide()),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            alignment: Alignment.topLeft,
                                            decoration: const BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10))),
                                            child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Text(
                                                // coupons[ind]['slot'],
                                                users[ind]['username'],
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                            )),
                                        Opacity(
                                          opacity: .5,
                                          child: FittedBox(
                                            child: Text(
                                              // getDateinFormat(
                                              //     coupons[ind]['creation'], "d MMM | h:mm a"),
                                              users[ind]['user'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w100),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            width: 70,
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0xFFD3D3D3)),
                                            child: Text(
                                              users[ind]['silver']['credit']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            )),
                                        Container(
                                            alignment: Alignment.center,
                                            width: 70,
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0xFFFFD700)),
                                            child: Text(
                                              users[ind]['gold']['credit']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                            )),
                                      ],
                                    ),
                                  ),
                                ])
                            // ListTile(
                            //   title: Container(
                            //       alignment: Alignment.topLeft,
                            //       decoration: const BoxDecoration(
                            //           color: Colors.transparent,
                            //           borderRadius: BorderRadius.only(
                            //               topLeft: Radius.circular(10),
                            //               topRight: Radius.circular(10))),
                            //       child: Text(
                            //         // coupons[ind]['slot'],
                            //         users[ind]['username'],
                            //         style: TextStyle(
                            //             fontSize: 25,
                            //             fontWeight: FontWeight.w900),
                            //       )),
                            //   subtitle: Opacity(
                            //     opacity: .5,
                            //     child: Text(
                            //       // getDateinFormat(
                            //       //     coupons[ind]['creation'], "d MMM | h:mm a"),
                            //       users[ind]['user'],
                            //       style: TextStyle(fontWeight: FontWeight.w100),
                            //     ),
                            //   ),
                            //   onTap: () {
                            //     // Navigator.pushNamed(context, 'coupon/qr',
                            //     //     arguments: {"name": coupons[ind]['name']});
                            //   },
                            //   hoverColor: Theme.of(context).colorScheme.secondary,
                            //   tileColor:
                            //       Theme.of(context).colorScheme.tertiaryContainer,
                            //   // tileColor: users[ind]['coupon_type'] == "Gold"
                            //   //     ? Color(0xFFFFD700)
                            //   //     : Color(0xFFD3D3D3),
                            //   textColor: Theme.of(context)
                            //       .colorScheme
                            //       .onTertiaryContainer,
                            // ),
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
