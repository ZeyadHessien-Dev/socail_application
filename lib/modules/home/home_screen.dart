import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_aplication/layout/layout_cubit/cubit.dart';
import 'package:social_aplication/layout/layout_cubit/states.dart';
import 'package:social_aplication/shared/components/components.dart';
import 'package:social_aplication/shared/style/icon_broken.dart';

import '../../model/post_model.dart';

class HomeScreen extends StatelessWidget {
  bool isHome = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {
        if (state is LoadingPostState || state is SuccessPostState) {
          isHome = false;
        }
        if (state is SuccessGetPostState) {
          isHome = true;
        }
      },
      builder: (context, state) {
        var listCubit = SocialLayoutCubit.get(context).listPost;
        var cubit = SocialLayoutCubit.get(context);
        return listCubit != null && cubit.userModel != null && isHome == true
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.grey,
                      margin: const EdgeInsets.all(
                        10.0,
                      ),
                      elevation: 20.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Container(
                            height: 230.0,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10.0,
                                ),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://img.freepik.com/free-photo/concept-winter-holidays-christmas-lifestyle-image-skeptical-young-man-white-sweater-dont-like-something-pointing-finger-left-looking-with-dismay-standing-red-background_1258-108291.jpg?w=2000',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Communicate with your friends',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildHome(listCubit[index], context, index),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                      itemCount: listCubit.length,
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget buildHome(PostModel model, context, index) => Card(
        color: Colors.white,
        margin: const EdgeInsets.all(
          10.0,
        ),
        elevation: 50.0,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                      model.image!,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              model.name!,
                            ),
                            const SizedBox(
                              width: 4.5,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          model.dateTime!,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: divideBy(),
              ),
              Text(
                model.text!,
                style: const TextStyle(
                  height: 1.45,
                  fontWeight: FontWeight.w100,
                  fontSize: 15.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (SocialLayoutCubit.get(context).listPost[index].imagePost !=
                  '')
                Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        10.0,
                      ),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        model.imagePost!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 6.5,
                          ),
                          Text(
                            '120',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            IconBroken.Paper_Upload,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 6.5,
                          ),
                          Text(
                            '120 Comment',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: divideBy(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        SocialLayoutCubit.get(context).userModel!.image!,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Expanded(
                      child: Text(
                        'Write a comment ...',
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 6.5,
                        ),
                        Text(
                          'Like',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
