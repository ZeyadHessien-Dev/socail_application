import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_aplication/layout/layout_cubit/cubit.dart';
import 'package:social_aplication/modules/login/login_cubit/states.dart';

import '../../../shared/components/constants.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isShow = true;
  Icon iconShow = const Icon(
    Icons.visibility,
  );

  void changePassword() {
    iconShow = isShow
        ? const Icon(Icons.visibility_off)
        : const Icon(Icons.visibility);
    isShow = !isShow;
    emit(LoginChangePasswordState());
  }

// FireBase
  void loginUser(context, {
    required String email,
    required String password,
  }) {
    emit(LoadingLoginUserState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email.replaceAll(' ', ''),
      password: password,
    ).then((value) {
      UID = value.user!.uid;
      emit(SuccessLoginUserState(value.user!.uid));
      SocialLayoutCubit.get(context).getUser();
      SocialLayoutCubit.get(context).getAllUser();
      SocialLayoutCubit.get(context).getPost();
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLoginUserState(error.toString()));
    });
  }
}
