import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_aplication/layout/layout_cubit/cubit.dart';
import 'package:social_aplication/layout/socail_layout.dart';
import 'package:social_aplication/modules/login/login_screen.dart';
import 'package:social_aplication/shared/bloc_observer.dart';
import 'package:social_aplication/shared/components/constants.dart';
import 'package:social_aplication/shared/network/local/cache_helper.dart';
import 'package:social_aplication/shared/network/remote/dio_helper.dart';
import 'package:social_aplication/shared/style/theme.dart';
import 'firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final storage = FirebaseStorage.instance;

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget startWidget;
  UID = CacheHelper.getStringData(key: 'token') ?? '';
  print(UID);
  if (UID !=  '') {
    startWidget = SocialLayoutScreen();
  } else {
    startWidget = LoginScreen();
  }


  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SocialLayoutCubit()..getUser()..getPost()..getAllUser())
      ],
      child: MaterialApp(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}

