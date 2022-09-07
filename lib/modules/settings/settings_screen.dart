import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_aplication/layout/layout_cubit/cubit.dart';
import 'package:social_aplication/shared/components/components.dart';
import 'package:social_aplication/shared/style/icon_broken.dart';

import '../../layout/layout_cubit/states.dart';
import '../edit_profile/edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitModel = SocialLayoutCubit.get(context).userModel;
        return cubitModel != null
            ? Column(
                children: [
                  Container(
                    height: 240,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Card(
                            margin: const EdgeInsets.all(
                              10.0,
                            ),
                            child: Container(
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius:
                                const BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(10.0),
                                  topStart: Radius.circular(10.0),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    cubitModel.cover!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 70.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 65.0,
                            backgroundImage: NetworkImage(
                              cubitModel.image!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    cubitModel.name!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    cubitModel.bio!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '1k',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: 5.5,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '5k',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: 5.5,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '2k',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: 5.5,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '500',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: 5.5,
                            ),
                            Text(
                              'Subscriber',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text(
                            'Add Photo',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 7.5,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          navigateTo(context, EditProfile());
                        },
                        child: const Icon(
                          IconBroken.Edit,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
