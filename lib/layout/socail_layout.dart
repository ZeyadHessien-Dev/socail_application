import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/style/icon_broken.dart';
import 'layout_cubit/cubit.dart';
import 'layout_cubit/states.dart';

class SocialLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Notification,),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Search,),
              ),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavigator(context,index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Upload,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Setting,
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
