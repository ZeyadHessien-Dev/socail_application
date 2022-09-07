import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_aplication/layout/socail_layout.dart';
import 'package:social_aplication/modules/register/register_cubit/cubit.dart';
import 'package:social_aplication/modules/register/register_cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';


class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is SuccessCreateUserState) {
            buildToast(message: 'Register Successfully', state: Cases.SUCCESS).then((value) {
              CacheHelper.setData(key: 'token', value: state.uid);
              print(UID);
              navigateAndFinish(context, SocialLayoutScreen());
            });
          }
          if (state is ErrorCreateUserState) {
            buildToast(message: state.error, state: Cases.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Register to communicate with your friends ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextForm(
                          controller: nameController,
                          labelText: 'Name',
                          prefixIcon: Icons.person,
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
                          controller: emailController,
                          labelText: 'Email',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email Must Not Be Null';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextForm(
                          controller: passwordController,
                          labelText: 'Password',
                          prefixIcon: Icons.lock,
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changePassword();
                            },
                            icon: cubit.iconShow,
                          ),
                          obscureText: cubit.isShow,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password Must Not Be Null';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextForm(
                          controller: phoneController,
                          labelText: 'Phone',
                          prefixIcon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone Must Not Be Null';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                          onPressed: () {
                            cubit.registerUser(
                              context,
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                          },
                          text: 'REGISTER',
                        ),
                        if (state is LoadingRegisterUserState)
                          const SizedBox(height: 7.5,),
                        if (state is LoadingRegisterUserState)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
