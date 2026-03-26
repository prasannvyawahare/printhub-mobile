import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../../controllers/google_sign_in_controller.dart';
import 'event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final googleSignInController = Get.put(GoogleSignInController());  // add in repository
  LoginBloc() : super(LoginState(  status: AuthStatus.initial)){
    on<GoogleLoginRequested>(_googleLoginRequested);
  }
  FutureOr<void> _googleLoginRequested(LoginEvent event, Emitter<LoginState> emit) {
    googleSignInController.signInWithGoogle();
  }
}
