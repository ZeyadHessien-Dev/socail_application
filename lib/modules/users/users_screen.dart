import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_aplication/layout/layout_cubit/cubit.dart';
import 'package:social_aplication/layout/layout_cubit/states.dart';
import 'package:social_aplication/modules/chats/chats_screen.dart';
import 'package:social_aplication/shared/components/components.dart';

import '../../model/user_model.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var listCubit = SocialLayoutCubit.get(context).listUsers;
        return listCubit != null
            ? ListView.separated(
                itemBuilder: (context, index) =>
                    buildAllUsers(context, listCubit[index]),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                  child: divideBy(),
                ),
                itemCount: listCubit.length,
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget buildAllUsers(context, UserModel model) => InkWell(
    onTap: () {
      navigateTo(context, ChatScreen(model));
    },
    child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage(
                  model.image!,
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                model.name!,
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
  );
}
