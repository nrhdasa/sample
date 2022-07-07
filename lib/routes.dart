import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/Auth%20Cubit/auth_cubit.dart';
import 'package:sample/Coupon%20Operations/coupon.dart';
import 'package:sample/Reports/generated_coupons.dart';
import 'package:sample/Reports/users_coupons.dart';
import 'package:sample/Resources/success_page.dart';

import 'Auth/login.dart';
import 'Coupon Operations/generate.dart';
import 'Coupon Operations/release.dart';
import 'Coupon Operations/request.dart';
import 'Coupon Operations/transfer.dart';
import 'Coupon Operations/transfer_select.dart';
import 'Home/home.dart';
import 'Internet Cubit/internet_cubit.dart';

class RouteGenerator {
  final AuthCubit _authCubit = AuthCubit();
  final InternetCubit _internetCubit = InternetCubit();

  Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider<InternetCubit>.value(
                  value: _internetCubit,
                  child: BlocProvider<AuthCubit>.value(
                    value: _authCubit,
                    child: const Home(),
                  ),
                ));

      case "login":
        return MaterialPageRoute(
            builder: (_) => BlocProvider<InternetCubit>.value(
                  value: _internetCubit,
                  child: BlocProvider<AuthCubit>.value(
                    value: _authCubit,
                    child: const Login(),
                  ),
                ));

      case "coupon/request":
        return MaterialPageRoute(
            builder: (_) => BlocProvider<InternetCubit>.value(
                  value: _internetCubit,
                  child: BlocProvider<AuthCubit>.value(
                    value: _authCubit,
                    child: const CouponRequest(),
                  ),
                ));
      case "coupon/release":
        return MaterialPageRoute(
            builder: (_) => BlocProvider<InternetCubit>.value(
                  value: _internetCubit,
                  child: BlocProvider<AuthCubit>.value(
                    value: _authCubit,
                    child: const CouponRelease(),
                  ),
                ));

      case "coupon/transfer_select":
        return MaterialPageRoute(
            builder: (_) => BlocProvider<InternetCubit>.value(
                  value: _internetCubit,
                  child: BlocProvider<AuthCubit>.value(
                    value: _authCubit,
                    child: const TransferSelect(),
                  ),
                ));

      case "coupon/transfer":
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<InternetCubit>.value(
                  value: _internetCubit,
                  child: BlocProvider<AuthCubit>.value(
                    value: _authCubit,
                    child: CouponTransfer(
                      transferUserDetails: args,
                    ),
                  ),
                ));

      case "coupon/generate":
        return MaterialPageRoute(
            builder: (_) => BlocProvider<InternetCubit>.value(
                  value: _internetCubit,
                  child: BlocProvider<AuthCubit>.value(
                    value: _authCubit,
                    child: const CouponGenerate(),
                  ),
                ));

      case "coupon/qr":
        final args = settings.arguments as Map<String, dynamic>;
        print(args);
        return MaterialPageRoute(
            builder: (_) => BlocProvider<InternetCubit>.value(
                  value: _internetCubit,
                  child: BlocProvider<AuthCubit>.value(
                    value: _authCubit,
                    child: CouponQR(
                      couponName: args['name'],
                    ),
                  ),
                ));

      case "report/generated_coupons":
        return MaterialPageRoute(
            builder: (_) => BlocProvider<InternetCubit>.value(
                  value: _internetCubit,
                  child: BlocProvider<AuthCubit>.value(
                    value: _authCubit,
                    child: GeneratedCoupons(),
                  ),
                ));
      case "report/users_coupons":
        return MaterialPageRoute(
            builder: (_) => BlocProvider<InternetCubit>.value(
                  value: _internetCubit,
                  child: BlocProvider<AuthCubit>.value(
                    value: _authCubit,
                    child: const UserCoupons(),
                  ),
                ));
      case "success":
        return MaterialPageRoute(builder: (_) => const SuccessPage());

      default:
        return MaterialPageRoute(
            builder: (_) => const Center(
                  child: Text("Not Specified"),
                ));
    }
  }

  void dispose() {
    _authCubit.close();
    _internetCubit.close();
  }
}
