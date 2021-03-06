import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

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
            String _code = "";
            // if (snap.data!.containsKey(key)) {
            //   _code = snap.data!.keys.firstWhere((k) => k == 'qr_code');
            // }
            if (snap.data == null) {
              return Container(child: Text("error"));
            } else {
              _code = snap.data!['qr_code'];
            }

            return SafeArea(
              child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
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
                                      offset: Offset(2, 2),
                                      blurRadius: 50)
                                ],
                                color: snap.data!['coupon_type'] == "Gold"
                                    ? Color(0xFFFFD700)
                                    : Color(0xFFD3D3D3),
                              ),
                              child: Text(
                                snap.data!['coupon_type']
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
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
                                  offset: Offset(2, 2),
                                  blurRadius: 50)
                            ], color: Theme.of(context).colorScheme.primary),
                            child: Text(
                              snap.data!['number'].toString(),
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      QRImage(
                        width: double.infinity,
                        qrcode: _code,
                      ),
                      Row(children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary),
                            child: Text(
                              getDateinFormat(snap.data!['date'], "d MMM"),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 200,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer),
                            child: Text(
                              getDateinFormat(snap.data!['date'], "EEEE"),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await shareQRcode(_code);
                          // String path = await getQRFileAddress(couponName);
                          // Share.shareFiles([path], text: 'QR Code');
                        },
                        child: Icon(
                          Icons.share,
                          size: 50,
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          primary:
                              Theme.of(context).colorScheme.tertiaryContainer,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
