import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_aplication/layout/layout_cubit/states.dart';
import 'package:social_aplication/model/message_model.dart';
import 'package:social_aplication/model/post_model.dart';
import 'package:social_aplication/model/user_model.dart';
import 'package:social_aplication/modules/home/home_screen.dart';
import 'package:social_aplication/modules/posts/post_screen.dart';
import 'package:social_aplication/modules/settings/settings_screen.dart';
import 'package:social_aplication/modules/users/users_screen.dart';
import 'package:social_aplication/shared/components/components.dart';
import '../../shared/components/constants.dart';

class SocialLayoutCubit extends Cubit<SocialLayoutStates> {
  SocialLayoutCubit() : super(InitialSocialLayoutState());

  static SocialLayoutCubit get(context) => BlocProvider.of(context);

  List<Widget> screen = [
    HomeScreen(),
    UsersScreen(),
    PostsScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Users',
    'Posts',
    'Settings',
  ];

  int currentIndex = 0;

  void changeBottomNavigator(context, index) {
    if (index == 2) {
      navigateTo(context, PostsScreen());
    } else {
      currentIndex = index;
    }
    emit(ChangeBottomNavigatorState());
  }

  UserModel? userModel;

  void getUser() {
    FirebaseFirestore.instance.collection('Users').doc(UID).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(SuccessGetUserState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetUserState(error.toString()));
    });
  }

  File? imageProfile;
  var picker = ImagePicker();

  Future<void> getImageProfile() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      imageProfile = File(pickedFile.path);
      emit(SuccessPickImageState());
    } else {
      print('No image selected');
      emit(ErrorPickImageState());
    }
  }

  void uploadImageProfile({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(LoadingUploadImageProfileState());
    FirebaseStorage.instance
        .ref()
        .child('User/${Uri.file(imageProfile!.path).pathSegments.last}')
        .putFile(imageProfile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateInfo(name: name, bio: bio, phone: phone, image: value);
      }).catchError((error) {
        print(error.toString());
        emit(ErrorUploadImageProfileState(error.toString()));
      });
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUploadImageProfileState(error.toString()));
    });
  }

  File? imageCover;

  Future<void> getImageCover() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      imageCover = File(pickedFile.path);
      emit(SuccessPickCoverState());
    } else {
      print('No image selected');
      emit(ErrorPickCoverState());
    }
  }

  void uploadImageCover({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(LoadingUploadCoverState());
    FirebaseStorage.instance
        .ref()
        .child('User${Uri.file(imageCover!.path).pathSegments.length}')
        .putFile(imageCover!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateInfo(name: name, bio: bio, phone: phone, cover: value);
      }).catchError((error) {
        print(error.toString());
        emit(ErrorUploadCoverState(error.toString()));
      });
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUploadCoverState(error.toString()));
    });
  }

  void updateInfo({
    required String name,
    required String bio,
    required String phone,
    String? image,
    String? cover,
  }) {
    UserModel updateData = UserModel(
      name: name,
      email: userModel!.email,
      bio: bio,
      phone: phone,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
    );
    emit(LoadingUpdateInfoState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(UID)
        .update(updateData.toMap())
        .then((value) {
      getUser();
      getAllUser();
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateInfoState(error.toString()));
    });
  }

  File? imagePost;

  Future<void> getImagePost() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      imagePost = File(pickedFile.path);
      emit(SuccessPickImagePostState());
    } else {
      print('No image selected');
      emit(ErrorPickImagePostState());
    }
  }

  void removePostImage() {
    imagePost = null;
    emit(SuccessRemoveImageState());
  }

  void uploadImagePost({
    required String name,
    required String text,
    required String dateTime,
    required String uid,
    required String image,
  }) {
    emit(LoadingPostImageState());
    FirebaseStorage.instance
        .ref()
        .child('Post${Uri.file(imagePost!.path).pathSegments.length}')
        .putFile(imagePost!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        postData(
          name: name,
          text: text,
          dateTime: dateTime,
          uid: uid,
          image: image,
          imagePost: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(ErrorPostImageState(error.toString()));
      });
    }).catchError((error) {
      print(error.toString());
      emit(ErrorPostImageState(error.toString()));
    });
  }

  void postData({
    required String name,
    required String text,
    required String dateTime,
    required String uid,
    required String image,
    String? imagePost,
  }) {
    emit(LoadingPostState());
    PostModel postModel = PostModel(
      name: name,
      image: image,
      dateTime: dateTime,
      text: text,
      uid: uid,
      imagePost: imagePost ?? '',
    );
    FirebaseFirestore.instance
        .collection('Post')
        .add(postModel.toMap())
        .then((value) {
      getPost();
      emit(SuccessPostState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorPostState(error.toString()));
    });
  }

  List<PostModel> listPost = [];

  void getPost() {
    FirebaseFirestore.instance.collection('Post').get().then((value) {
      listPost = [];
      for (var element in value.docs) {
        listPost.add(PostModel.fromJson(element.data()));
      }
      emit(SuccessGetPostState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetPostState(error.toString()));
    });
  }

  List<UserModel> listUsers = [];
  List<String> UIDS = [];

  void getAllUser() {
    emit(LoadingGetAllUserState());
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      listUsers = [];
      UIDS = [];
      value.docs.forEach((element) {
        UIDS.add(element.id);
        if (element.id != UID) {
          listUsers.add(UserModel.fromJson(element.data()));
        }
        emit(SuccessGetAllUserState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetAllUserState(error.toString()));
    });
  }
  void sendMessage({
    required String text,
    String? senderUid,
    required String dateTime,
    required String receiverUid,
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      dateTime: dateTime,
      senderUID: UID,
      receiverUID: receiverUid,
    );
    emit(LoadingSendMessagesState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(UID)
        .collection('Chat')
        .doc(receiverUid)
        .collection('Messages')
        .add(messageModel.toMap())
        .then((value) {})
        .catchError((error) {
      emit(ErrorSendMessagesState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverUid)
        .collection('Chat')
        .doc(UID)
        .collection('Messages')
        .add(messageModel.toMap())
        .then((value) {
      getMessage(
        receiverUid: receiverUid,
      );
    }).catchError((error) {
      emit(ErrorSendMessagesState(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  getMessage({
    required String receiverUid,
  }) {
    emit(LoadingGetMessagesState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(UID)
        .collection('Chat')
        .doc(receiverUid)
        .collection('Messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(SuccessGetMessagesState());
    });
  }


}
