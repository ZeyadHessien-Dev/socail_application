import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_aplication/layout/layout_cubit/cubit.dart';
import 'package:social_aplication/layout/layout_cubit/states.dart';
import 'package:social_aplication/shared/style/icon_broken.dart';

class PostsScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {
        if (state is SuccessPostState) {
          textController.clear();
          SocialLayoutCubit.get(context).removePostImage();
        }
      },
      builder: (context, state) {
        var cubit = SocialLayoutCubit.get(context);
        var modelCubit = SocialLayoutCubit.get(context).userModel;
        return modelCubit != null
            ? Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: const [
                      Text(
                        'Create Post',
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (cubit.imagePost == null) {
                          cubit.postData(
                            name: modelCubit.name!,
                            text: textController.text,
                            dateTime: DateTime.now().toString(),
                            uid: modelCubit.uid!,
                            image: modelCubit.image!,
                          );
                        }

                        if (cubit.imagePost != null) {
                          cubit.uploadImagePost(
                            name: modelCubit.name!,
                            text: textController.text,
                            dateTime: DateTime.now().toString(),
                            uid: modelCubit.uid!,
                            image: modelCubit.image!,
                          );
                        }
                      },
                      child: const Text(
                        'POST',
                      ),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if (state is LoadingPostState || state is LoadingPostImageState)
                        const LinearProgressIndicator(),
                      if (state is LoadingPostState || state is LoadingPostImageState)
                        const SizedBox(height: 15,),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                              cubit.userModel!.image!,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                           Text(
                            cubit.userModel!.name!,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: textController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write Your Post',
                              helperStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                      if (cubit.imagePost != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 165.0,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    10.0,
                                  ),
                                ),
                                image: DecorationImage(
                                  image: FileImage(cubit.imagePost!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                cubit.removePostImage();
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  right: 10.0,
                                  top: 10.0,
                                ),
                                child: CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.remove_circle_outlined,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                cubit.getImagePost();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    IconBroken.Image,
                                  ),
                                  SizedBox(
                                    width: 5.5,
                                  ),
                                  Text(
                                    'Add Photo',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text(
                                '# tags',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
