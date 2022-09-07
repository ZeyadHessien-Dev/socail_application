import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_aplication/layout/layout_cubit/cubit.dart';
import 'package:social_aplication/model/user_model.dart';
import 'package:social_aplication/modules/register/register_cubit/states.dart';

import '../../../shared/components/constants.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isShow = true;
  Icon iconShow = const Icon(
    Icons.visibility,
  );

  void changePassword() {
    iconShow = isShow
        ? const Icon(Icons.visibility_off)
        : const Icon(Icons.visibility);
    isShow = !isShow;
    emit(RegisterChangePasswordState());
  }

// FireBase
  void registerUser(context, {
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(LoadingRegisterUserState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      UID = value.user!.uid;
      createUser(context, name: name, email: email, phone: phone, uid: UID);
    }).catchError((error) {
      print(error.toString());
      emit(ErrorRegisterUserState(error.toString()));
    });
  }

  void createUser(context, {
    required String name,
    required String email,
    required String phone,
    required String uid,
    String? bio,
    String? image,
    String? cover,

  }) {
    UserModel userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      uid: uid,
      image: image ??
          'https://st.depositphotos.com/2101611/3925/v/600/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg',
      cover: cover ??
          'https://tokystorage.s3.amazonaws.com/images/default-cover.png',
      bio: bio ?? 'Write To Bio',
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(UID)
        .set(userModel.toMap())
        .then((value) {
          SocialLayoutCubit.get(context).getUser();
      emit(SuccessCreateUserState(uid));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCreateUserState(error.toString()));
    });
  }
}
