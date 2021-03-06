import 'package:flutter/material.dart';

class SlotDetails extends StatelessWidget {
  final Map<String, dynamic> data;
  const SlotDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> finaldata = filterData(data);
    const double distance = 10;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 320,
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
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     CircleAvatar(
              //         minRadius: 5,
              //         backgroundColor: Theme.of(context).colorScheme.surface,
              //         child: Container()),
              //     const SizedBox(
              //       height: distance,
              //     ),
              //     Row(
              //       children: [
              //         CircleAvatar(
              //             minRadius: 5,
              //             backgroundColor:
              //                 Theme.of(context).colorScheme.primary,
              //             child: Container()),
              //         const SizedBox(
              //           width: distance,
              //         ),
              //         CircleAvatar(
              //             minRadius: 5,
              //             backgroundColor:
              //                 Theme.of(context).colorScheme.surface,
              //             child: Container()),
              //       ],
              //     ),
              //     const SizedBox(
              //       height: distance,
              //     ),
              //     Row(
              //       children: [
              //         CircleAvatar(
              //             minRadius: 5,
              //             backgroundColor:
              //                 Theme.of(context).colorScheme.tertiaryContainer,
              //             child: Container()),
              //         const SizedBox(
              //           width: distance,
              //         ),
              //         CircleAvatar(
              //             minRadius: 5,
              //             backgroundColor:
              //                 Theme.of(context).colorScheme.primary,
              //             child: Container()),
              //         const SizedBox(
              //           width: distance,
              //         ),
              //         CircleAvatar(
              //             minRadius: 5,
              //             backgroundColor:
              //                 Theme.of(context).colorScheme.surface,
              //             child: Container()),
              //       ],
              //     ),
              //   ],
              // ),
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
            basicBlockForInformation(context,
                finaldata['data']['transfer_sent'].toString(), "Transferred"),
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
      height: 100,
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
              fontSize: 50,
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        Text(title)
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
      height: 100,
      width: 90,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.tertiaryContainer,
              Theme.of(context).colorScheme.secondary.withGreen(100),
            ],
          )),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          count,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: Theme.of(context).colorScheme.onTertiaryContainer),
        ),
        Text(title)
      ]),
    ),
  );
}

// decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.secondary.withOpacity(1),
//           boxShadow: [
//             BoxShadow(
//                 color: Theme.of(context).colorScheme.secondary,
//                 offset: Offset(4, 4),
//                 blurRadius: 10,
//                 spreadRadius: 1),
//             BoxShadow(
//                 color: Colors.white,
//                 offset: Offset(-4, -4),
//                 blurRadius: 10,
//                 spreadRadius: 1)
//           ],
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
//         ),