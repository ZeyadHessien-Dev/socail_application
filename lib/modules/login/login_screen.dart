import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_aplication/layout/socail_layout.dart';
import 'package:social_aplication/shared/network/local/cache_helper.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../register/register_screen.dart';
import 'login_cubit/cubit.dart';
import 'login_cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is SuccessLoginUserState) {
            buildToast(
              message: 'Log In Successfully',
              state: Cases.SUCCESS,
            ).then((value) {
              CacheHelper.setData(key: 'token', value: state.uid.toString());
              print(UID);
              navigateAndFinish(context, SocialLayoutScreen());
            });
          }
          if (state is ErrorLoginUserState) {
            buildToast(
              message: state.error,
              state: Cases.ERROR,
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
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
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Login to communicate with your friends ',
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
                          height: 20,
                        ),
                        defaultButton(
                          onPressed: () {
                            cubit.loginUser(
                              context,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                          text: 'LOGIN',
                        ),
                        if (state is LoadingLoginUserState)
                          const SizedBox(height: 7.5,),
                        if (state is LoadingLoginUserState)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account',
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: const Text(
                                'REGISTER NOW',
                              ),
                            ),
                          ],
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
