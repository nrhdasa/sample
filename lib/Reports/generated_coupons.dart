import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Auth Cubit/auth_widget.dart';
import '../Internet Cubit/internet_widget.dart';
import '../Resources/buttons.dart';
import '../Resources/common.dart';
import 'operations.dart';

class GeneratedCoupons extends StatefulWidget {
  const GeneratedCoupons({Key? key}) : super(key: key);

  @override
  State<GeneratedCoupons> createState() => _GeneratedCouponsState();
}

class _GeneratedCouponsState extends State<GeneratedCoupons> {
  List<dynamic> coupons = [];
  DateTime _operationDate =
      DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));

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
                      "Generated Coupons",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                HKMTextButton(
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        DateFormat('EEEE, dd MMM').format(_operationDate),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 25),
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
              ],
            ),
            shadowColor: Theme.of(context).colorScheme.shadow,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: FutureBuilder<List<dynamic>>(
              future: getGeneratedCoupons(context, _operationDate),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  coupons = snapshot.data!;
                  return ListView.builder(
                      itemCount: coupons.length,
                      itemBuilder: (context, ind) {
                        return Container(
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide()),
                          ),
                          child: ListTile(
                            trailing: Container(
                                alignment: Alignment.center,
                                width: 70,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                                child: Text(
                                  coupons[ind]['number'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                )),
                            title: Container(
                                alignment: Alignment.topLeft,
                                decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Text(
                                  coupons[ind]['slot'],
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900),
                                )),
                            subtitle: Opacity(
                              opacity: .5,
                              child: Text(
                                getDateinFormat(
                                    coupons[ind]['creation'], "d MMM | h:mm a"),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w100),
                              ),
                            ),
                            leading: const Icon(Icons.qr_code_2_outlined),
                            onTap: () {
                              Navigator.pushNamed(context, 'coupon/qr',
                                  arguments: {"name": coupons[ind]['name']});
                            },
                            hoverColor: Theme.of(context).colorScheme.secondary,
                            tileColor: coupons[ind]['coupon_type'] == "Gold"
                                ? const Color(0xFFFFD700)
                                : const Color(0xFFD3D3D3),
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
