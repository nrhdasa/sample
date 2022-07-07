import 'package:flutter/material.dart';

import '../Resources/common.dart';
import 'operations.dart';
import 'qr.dart';

class CouponQR extends StatelessWidget {
  final String couponName;
  const CouponQR({required this.couponName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: getCouponQR(context, couponName),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            String code = "";
            // if (snap.data!.containsKey(key)) {
            //   _code = snap.data!.keys.firstWhere((k) => k == 'qr_code');
            // }
            if (snap.data == null) {
              return const Text("error");
            } else {
              code = snap.data!['qr_code'];
            }

            return SafeArea(
              child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white.withOpacity(.8),
                                      offset: const Offset(2, 2),
                                      blurRadius: 50)
                                ],
                                color: snap.data!['coupon_type'] == "Gold"
                                    ? const Color(0xFFFFD700)
                                    : const Color(0xFFD3D3D3),
                              ),
                              child: Text(
                                snap.data!['coupon_type']
                                    .toString()
                                    .toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30),
                            height: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.white.withOpacity(.8),
                                  offset: const Offset(2, 2),
                                  blurRadius: 50)
                            ], color: Theme.of(context).colorScheme.primary),
                            child: Text(
                              snap.data!['number'].toString(),
                              style: const TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      QRImage(
                        width: double.infinity,
                        qrcode: code,
                      ),
                      Row(children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary),
                            child: Text(
                              getDateinFormat(snap.data!['date'], "d MMM"),
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 200,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer),
                            child: Text(
                              getDateinFormat(snap.data!['date'], "EEEE"),
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await shareQRcode(code);
                          // String path = await getQRFileAddress(couponName);
                          // Share.shareFiles([path], text: 'QR Code');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          primary:
                              Theme.of(context).colorScheme.tertiaryContainer,
                        ),
                        child: Icon(
                          Icons.share,
                          size: 50,
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
