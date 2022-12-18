import 'package:cat_task2/data/cubit/login_cubit.dart';
import 'package:cat_task2/data/network/local/cash_helper.dart';
import 'package:cat_task2/data/states/login_state.dart';
import 'package:cat_task2/ui/Screen/home.dart';
import 'package:cat_task2/ui/Screen/register.dart';
import 'package:cat_task2/ui/widget/componantes.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class AppLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit, AppLoginStates>(
        listener: (context, state) {
          if (state is AppLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, const HomeScreen());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 100.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "please enter your email address";
                            }
                            return null;
                          },
                          prefix: Icons.email, hint: 'Email Address',
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultFormField(
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              AppLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return " please enter your password ";
                            }
                            return null;
                          },
                          prefix: Icons.lock,
                          suffix: AppLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            AppLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          isPassword: AppLoginCubit.get(context).isPassword,
                          onChange: (value) {}, hint: 'Password',
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! AppLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                AppLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: "LOGIN",
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, RegisterAppScreen());
                                },
                                text: "REGISTER NOW")
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
