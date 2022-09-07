import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_aplication/layout/layout_cubit/cubit.dart';
import 'package:social_aplication/layout/layout_cubit/states.dart';
import 'package:social_aplication/shared/style/icon_broken.dart';

import '../../shared/components/components.dart';

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitModel = SocialLayoutCubit.get(context).userModel;
        var cubit = SocialLayoutCubit.get(context);
        nameController.text = cubitModel!.name!;
        bioController.text = cubitModel.bio!;
        phoneController.text = cubitModel.phone!;
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  cubit.updateInfo(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                  );
                },
                child: const Text(
                  'UPDATE',
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is LoadingUpdateInfoState)
                  const SizedBox(
                    height: 7.5,
                  ),
                if (state is LoadingUpdateInfoState)
                  const LinearProgressIndicator(),
                Container(
                  height: 240,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Card(
                              margin:  EdgeInsets.all(
                                10.0,
                              ),
                              child: Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius:
                                       BorderRadiusDirectional.only(
                                    topEnd: Radius.circular(10.0),
                                    topStart: Radius.circular(10.0),
                                  ),
                                  image: DecorationImage(
                                    image: cubit.imageCover == null
                                        ?  NetworkImage(
                                      cubitModel.cover!,
                                          )
                                        : FileImage(cubit.imageCover!)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: InkWell(
                              onTap: () {
                                cubit.getImageCover();
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.orange.withOpacity(.5),
                                child: const Icon(
                                  IconBroken.Camera,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 70.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 65.0,
                              backgroundImage: cubit.imageProfile != null
                                  ? FileImage(
                                      cubit.imageProfile!,
                                    ) as ImageProvider
                                  :  NetworkImage(
                                cubitModel.image!,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.getImageProfile();
                            },
                            icon: const CircleAvatar(
                              child: Icon(
                                IconBroken.Camera,
                                size: 25.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                if (cubit.imageCover != null || cubit.imageProfile != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        if (cubit.imageProfile != null)
                          Expanded(
                            child: defaultButton(
                              onPressed: () {
                                cubit.uploadImageProfile(
                                  name: nameController.text,
                                  bio: bioController.text,
                                  phone: phoneController.text,
                                );
                              },
                              text: 'Upload Image',
                            ),
                          ),
                        const SizedBox(
                          width: 20,
                        ),
                        if (cubit.imageCover != null)
                          Expanded(
                            child: defaultButton(
                              onPressed: () {
                                cubit.uploadImageCover(
                                  name: nameController.text,
                                  bio: bioController.text,
                                  phone: phoneController.text,
                                );
                              },
                              text: 'Upload Cover',
                            ),
                          ),
                      ],
                    ),
                  ),
                if (cubit.imageCover != null || cubit.imageProfile != null)
                  const SizedBox(
                    height: 30,
                  ),
                if (state is LoadingUploadCoverState)
                  const LinearProgressIndicator(),
                if (state is LoadingUploadImageProfileState)
                  const LinearProgressIndicator(),
                if (state is LoadingUploadCoverState || state is LoadingUploadImageProfileState)
                  const SizedBox(
                    height: 30,
                  ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      defaultTextForm(
                        controller: nameController,
                        labelText: 'Name',
                        prefixIcon: IconBroken.User,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name Must Not Be Null';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextForm(
                        controller: bioController,
                        labelText: 'Bio',
                        prefixIcon: IconBroken.Paper_Upload,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Bio Must Not Be Null';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextForm(
                        controller: phoneController,
                        labelText: 'Phone',
                        prefixIcon: IconBroken.Call,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone Must Not Be Null';
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
