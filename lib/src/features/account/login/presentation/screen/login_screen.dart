import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:life_weather_mobile/gen/assets.gen.dart';
import 'package:life_weather_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:life_weather_mobile/src/core/config/app_constant.dart';
import 'package:life_weather_mobile/src/core/local_storage/local_storage.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/account/login/data/repositories/login_repository_impl.dart';
import 'package:life_weather_mobile/src/features/account/login/presentation/widgets/login_form.dart';
import 'package:life_weather_mobile/src/features/account/profile/data/models/profile_model.dart';
import 'package:life_weather_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:life_weather_mobile/src/features/home/presentation/screens/home_navigation.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // testLoginValues();
    // testSignupValues();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.35;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.lottie.loginAnimation.lottie(
              height: height,
            ),
            LoginForm(
              emailController: emailCtrl,
              formKey: loginFormKey,
              passwordController: passwordCtrl,
              passwordVisible: _passwordVisible,
              onSubmit: handleLogin,
              suffixIcon: GestureDetector(
                onTap: handleOnChangePassVisible,
                child: Icon(!_passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleLogin() {
    if (loginFormKey.currentState!.validate()) {
      EasyLoading.show();

      LoginRepositoryImpl()
          .login(email: emailCtrl.value.text, password: passwordCtrl.value.text)
          .then((value) async {
        await LocalStorage.storeLocalStorage(
            '_token', value['data']['access_token']);
        await LocalStorage.storeLocalStorage(
            '_refreshToken', value['data']['refresh_token']);
        handleGetProfile();
      }).catchError((onError) {
        EasyLoading.dismiss();

        Future.delayed(const Duration(milliseconds: 500), () {
          CommonDialog.showMyDialog(
            context: context,
            title: AppConstant.appName,
            body: "Invalid email or password",
            isError: true,
          );
        });
      });
    }
  }

  void testLoginValues() {
    emailCtrl.text = "juandelacruz@gmail.com";
    passwordCtrl.text = "2023Rtutest@";
  }

  void handleGetProfile() async {
    await ProfileRepositoryImpl().fetchProfile().then((profile) async {
      EasyLoading.dismiss();

      handleSetProfileBloc(profile);
      await LocalStorage.storeLocalStorage('_user', profile.toString());

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeNavigation.routeName,
          (route) => false,
        );
      });
    }).catchError((onError) {
      EasyLoading.dismiss();
      Future.delayed(const Duration(milliseconds: 500), () {
        CommonDialog.showMyDialog(
          context: context,
          title: AppConstant.appName,
          body: onError['data']['error_message'],
          isError: true,
        );
      });
    });
  }

  void handleSetProfileBloc(ProfileModel profile) {
    BlocProvider.of<ProfileBloc>(context).add(
      SetProfileEvent(profile: profile),
    );
  }

  void handleOnChangePassVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
