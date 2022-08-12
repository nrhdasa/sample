import 'package:flutter/material.dart';

class SlotDetails extends StatelessWidget {
  final Map<String, dynamic> data;
  const SlotDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ;
    // ;
    if (data['data'].length == 0) {
      return const Text(
        "No Data Received.Please contact Admin",
        style: TextStyle(color: Colors.white),
      );
    }
    Map<String, dynamic> finaldata = filterData(data);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                color: Colors.transparent,
                elevation: 5,
                child: Row(
                  children: [
                    Container(
                      height: 55,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primaryContainer,
                              Theme.of(context).colorScheme.tertiaryContainer,
                            ],
                          )),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Credits Left",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                                child: Text(
                                  finaldata['data']['credit'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            specialBlockForInformation(
                context, finaldata['data']['used'].toString(), "Served"),
            specialBlockForInformation(
                context, finaldata['data']['generated'].toString(), "QR"),
            specialBlockForInformation(context,
                finaldata['data']['transfer_rec'].toString(), "Received")
          ],
        ),
        Row(
          children: [
            basicBlockForInformation(
                context, finaldata['data']['request'].toString(), "Requested"),
            basicBlockForInformation(
                context, finaldata['data']['release'].toString(), "Released"),
            basicBlockForInformation(
                context, finaldata['data']['transfer_sent'].toString(), "Sent"),
          ],
        ),
      ],
    );
  }

  Map<String, dynamic> filterData(Map<String, dynamic> data) {
    Map<String, dynamic> finalData = {};

    //Getting Slot
    List<bool> slot = data['slot'] as List<bool>;
    List<String> slots = ["Morning", "Afternoon", "Evening"];
    for (int i = 0; i < slots.length; i++) {
      if (slot[i]) {
        finalData['slot'] = slots[i];
        break;
      }
    }
    //Getting Coupon Type
    List<bool> couponType = data['type'] as List<bool>;
    List<String> couponTypes = ["Silver", "Gold"];
    for (int i = 0; i < couponTypes.length; i++) {
      if (couponType[i]) {
        finalData['couponType'] = couponTypes[i];
        break;
      }
    }

    //Getting Data
    var counts = data['data']['message'] as List<dynamic>;
    var countsData =
        counts.firstWhere((element) => element['slot'] == finalData['slot']);
    finalData['data'] =
        countsData[finalData['couponType'].toString().toLowerCase()];

    return finalData;
  }
}

Widget basicBlockForInformation(
    BuildContext context, String count, String title) {
  return Card(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    color: Colors.transparent,
    elevation: 5,
    child: Container(
      padding: EdgeInsets.all(8),
      // height: 100,
      width: 90,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.tertiaryContainer,
            ],
          )),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          count,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        FittedBox(fit: BoxFit.cover, child: Text(title))
      ]),
    ),
  );
}

Widget specialBlockForInformation(
    BuildContext context, String count, String title) {
  return Card(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    color: Colors.transparent,
    elevation: 5,
    child: Container(
      padding: EdgeInsets.all(10),
      width: 90,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.tertiaryContainer,
              Theme.of(context).colorScheme.secondary.withGreen(100),
            ],
          )),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          count,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Theme.of(context).colorScheme.onTertiaryContainer),
        ),
        FittedBox(fit: BoxFit.contain, child: Text(title))
      ]),
    ),
  );
}
