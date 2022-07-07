import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample/Resources/buttons.dart';
import 'package:sample/Resources/common.dart';

import '../Auth Cubit/auth_widget.dart';
import '../Internet Cubit/internet_widget.dart';
import 'operations.dart';

class CouponTransfer extends StatefulWidget {
  final Map<String, dynamic> transferUserDetails;
  const CouponTransfer({required this.transferUserDetails, Key? key})
      : super(key: key);

  @override
  State<CouponTransfer> createState() => _CouponTransferState();
}

class _CouponTransferState extends State<CouponTransfer> {
  final _formKey = GlobalKey<FormState>();
  DateTime _operationDate = DateTime.now();
  final TextEditingController _couponCountController = TextEditingController();
  final Map<String, dynamic> _formData = {};
  @override
  void initState() {
    _couponCountController.text = "1";
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
                  "Coupon Transfer",
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
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: const Text("Selected User"),
                        ),
                        Text(
                          widget.transferUserDetails['user']['full_name'],
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              fontSize: 25.0),
                        ),
                        Text(
                          widget.transferUserDetails['user']['name'],
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer
                                  .withOpacity(.7),
                              fontSize: 15.0),
                        )
                      ],
                    ),
                    Divider(
                      height: 50,
                      indent: 50,
                      thickness: 2,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 41.0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          HKMTextButton(
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today_outlined,
                                    size: 40,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  DateFormat('EEEE, dd MMM')
                                      .format(_operationDate),
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 25),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              DateTime? datetime = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime.now().add(const Duration(days: 7)),
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
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
                    ),
                    DropdownButtonFormField<String>(
                      onSaved: (newValue) {
                        setState(() {
                          _formData['slot'] = newValue;
                        });
                      },
                      dropdownColor: Theme.of(context).colorScheme.onSurface,
                      isDense: false,
                      itemHeight: 60,
                      isExpanded: true,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 25.0),
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.arrow_drop_down),
                      ),
                      validator: (val) {
                        return val == null ? "Value can't blank" : null;
                      },
                      decoration: InputDecoration(
                        labelText: "Slot",
                        icon: Icon(
                          Icons.timer_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 30,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.7),
                            width: 5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 7,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.background,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                            width: 5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                      ),
                      items: ["Morning", "Afternoon", "Evening"].map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (val) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<String>(
                      onSaved: ((newValue) {
                        setState(() {
                          _formData['coupon_type'] = newValue;
                        });
                      }),
                      dropdownColor: Theme.of(context).colorScheme.onSurface,
                      isDense: false,
                      itemHeight: 60,
                      isExpanded: true,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 25.0),
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.arrow_drop_down),
                      ),
                      decoration: InputDecoration(
                        labelText: "Coupon Type",
                        icon: Icon(
                          Icons.timer_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 30,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.7),
                            width: 5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 7,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.background,
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                      ),
                      validator: (val) {
                        return val == null ? "Value can't blank" : null;
                      },
                      items: ["Silver", "Gold"].map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (val) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HKMGeneralButton(
                              onPressed: () {
                                _updateCount("minus");
                              },
                              child: const Icon(
                                Icons.remove,
                                size: 40,
                              )),
                          SizedBox(
                            width: 120,
                            child: TextFormField(
                              onSaved: ((newValue) {
                                setState(() {
                                  _formData['number'] = newValue;
                                });
                              }),
                              validator: (val) {
                                return val == null ? "Value can't blank" : null;
                              },
                              controller: _couponCountController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 40,
                              ),
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(.7),
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 7,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor:
                                    Theme.of(context).colorScheme.surface,
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 16, 0),
                              ),
                            ),
                          ),
                          HKMGeneralButton(
                              onPressed: () {
                                _updateCount("plus");
                              },
                              child: const Icon(
                                Icons.add,
                                size: 40,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  _formData['date'] = DateFormat('yyyy-MM-dd')
                                      .format(_operationDate);
                                  _formData['transfer_to'] = widget
                                      .transferUserDetails['user']['name'];
                                  await createTransfer(context, _formData);
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 20.0, bottom: 20),
                                child: Text(
                                  "Transfer",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateCount(String s) {
    if (isNumeric(_couponCountController.text)) {
      var currentValue = int.parse(_couponCountController.text);
      var updatedValue = 0;
      if (s == "plus") {
        updatedValue = currentValue + 1;
      } else if (s == "minus") {
        updatedValue = currentValue - 1;
      }

      if (updatedValue < 1 || updatedValue > 100) {
        snackBarError(context, "Count can be in between 1 to 100 Only!");
      } else {
        setState(() {
          _couponCountController.text = updatedValue.toString();
        });
      }
    } else {
      snackBarError(context, "Count can't be a String");
    }
  }
}
