import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/conf/page_route_name.dart';
import 'package:todo_app/core/services/show_snack_bar.dart';
import 'package:todo_app/features/auth/manager/auth_cubit/auth_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var provider = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthloadingLogin) {
          EasyLoading.show(status: 'login'.tr());
        } else if (state is AuthFailureLogin) {
          EasyLoading.dismiss();
          showSnackBar(context, state.errmessage);
        } else if (state is AuthSuccessLogin) {
          EasyLoading.dismiss();
          Navigator.pushReplacementNamed(context, PageRouteName.layOut);
        } else {
          EasyLoading.dismiss();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: mediaQuery.size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/153099_adapted_1080x2400.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: mediaQuery.size.height * 0.1, left: 20, right: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('login'.tr(),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge?.copyWith(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        SizedBox(
                          height: mediaQuery.size.height * 0.1,
                        ),
                        Text(
                          'welcome_back'.tr(),
                          textAlign: TextAlign.left,
                          style: theme.textTheme.titleLarge?.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextFormField(
                          controller: _emailController,
                          cursorColor: theme.primaryColor,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "enter_your_email".tr(),
                            labelText: "email".tr(),
                            hintStyle: theme.textTheme.displaySmall
                                ?.copyWith(color: Colors.black, fontSize: 18),
                            labelStyle: theme.textTheme.bodySmall
                                ?.copyWith(color: Colors.black),
                            suffixIcon: const Icon(Icons.email),
                          ),
                          validator: (value) {
                            var emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]');
                            if (value == null || value.trim().isEmpty) {
                              return 'please_enter_your_email'.tr();
                            } else if (!emailRegex.hasMatch(value)) {
                              return 'enter_valid_email'.tr();
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passController,
                          obscureText: !_isPasswordVisible,
                          cursorColor: theme.primaryColor,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "enter_your_password".tr(),
                            labelText: "password".tr(),
                            hintStyle: theme.textTheme.displaySmall
                                ?.copyWith(color: Colors.black, fontSize: 18),
                            labelStyle: theme.textTheme.bodySmall
                                ?.copyWith(color: Colors.black),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'please_enter_your_password'.tr();
                            } else if (value.length < 6) {
                              return 'password_min_length'.tr();
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'forgot_password'.tr(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              backgroundColor: theme.primaryColor,
                              overlayColor:
                                  const Color.fromARGB(255, 151, 194, 250),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              )),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              provider.signIn(
                                email: _emailController.text.trim(),
                                password: _passController.text.trim(),
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "login".tr(),
                                style: theme.textTheme.bodyLarge,
                              ),
                              const Icon(
                                Icons.double_arrow_rounded,
                                size: 30,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, PageRouteName.regestration);
                          },
                          child: Text(
                            'create_my_account'.tr(),
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
