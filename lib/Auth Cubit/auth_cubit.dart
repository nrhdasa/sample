import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState { signedIn, signedOut }

class AuthCubit extends Cubit<AuthState> {
  final authstream = AuthStream();

  StreamSubscription? _authSubscription;
  AuthCubit() : super(AuthState.signedOut) {
    _authSubscription = authstream._controller.stream.listen((state) {
      if (state) {
        emit(AuthState.signedIn);
      } else {
        emit(AuthState.signedOut);
      }
    });
  }
  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}

class AuthStream {
  final _controller = StreamController<bool>();
  late SharedPreferences prefs;
  AuthStream() {
    _controller.sink.add(true);
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      if (token == null) {
        _controller.sink.add(false);
      } else {
        _controller.sink.add(true);
      }
    });
  }

  Stream get stream => _controller.stream;
}
