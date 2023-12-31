import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:life_weather_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:life_weather_mobile/src/core/config/app_constant.dart';
import 'package:life_weather_mobile/src/core/local_storage/local_storage.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/account/login/data/repositories/login_repository_impl.dart';
import 'package:life_weather_mobile/src/features/account/profile/data/models/profile_model.dart';
import 'package:life_weather_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:life_weather_mobile/src/features/account/signup/data/models/signup_model.dart';
import 'package:life_weather_mobile/src/features/account/signup/data/data_sources/signup_repository_impl.dart';
import 'package:life_weather_mobile/src/features/account/signup/presentation/widgets/signup_form.dart';
import 'package:life_weather_mobile/src/features/home/presentation/screens/home_navigation.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailSignupCtrl = TextEditingController();
  final TextEditingController passwordSignupCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController genderCtrl = TextEditingController();

  final signupFormKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _passwordConfirmVisible = true;

  @override
  void initState() {
    // handleTestValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Signup',
        isDarkMode: true,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: SignupForm(
            onSelectGender: (value) {
              genderCtrl.value =
                  TextEditingController.fromValue(TextEditingValue(text: value))
                      .value;
            },
            genderCtrl: genderCtrl,
            firstNameCtrl: firstNameCtrl,
            lastNameCtrl: lastNameCtrl,
            emailCtrl: emailSignupCtrl,
            passwordCtrl: passwordSignupCtrl,
            confirmPasswordCtrl: confirmPasswordCtrl,
            formKey: signupFormKey,
            onSubmit: handleSignup,
            confirmPasswordVisible: _passwordConfirmVisible,
            confirmSuffixIcon: GestureDetector(
              onTap: handleOnConfirmChangePassVisible,
              child: Icon(!_passwordConfirmVisible
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
            passwordVisible: _passwordVisible,
            suffixIcon: GestureDetector(
              onTap: handleOnChangePassVisible,
              child: Icon(
                  !_passwordVisible ? Icons.visibility : Icons.visibility_off),
            ),
          ),
        ),
      ),
    );
  }

  void handleTestValues() {
    emailSignupCtrl.text = 'juandelacruz@gmail.com';
    passwordSignupCtrl.text = '2020Rtutest@';
    confirmPasswordCtrl.text = '2020Rtutest@';
    firstNameCtrl.text = 'juan';
    lastNameCtrl.text = 'dela cruz';
    genderCtrl.text = 'male';
  }

  void handleOnChangePassVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void handleOnConfirmChangePassVisible() {
    setState(() {
      _passwordConfirmVisible = !_passwordConfirmVisible;
    });
  }

  void handleSignup() {
    if (signupFormKey.currentState!.validate()) {
      EasyLoading.show();

      final signup = SignupModel(
        email: emailSignupCtrl.text,
        password: passwordSignupCtrl.text,
        confirmPassword: confirmPasswordCtrl.text,
        firstName: firstNameCtrl.text,
        lastName: lastNameCtrl.text,
        gender: genderCtrl.text.toLowerCase() == 'male' ? "M" : "F",
      );
      SignupImpl().register(signup).then((value) {
        EasyLoading.dismiss();

        Future.delayed(const Duration(milliseconds: 500), () {
          handleLogin(
            email: emailSignupCtrl.text,
            password: passwordSignupCtrl.text,
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
    } else {}
  }

  void handleLogin({
    required String email,
    required String password,
  }) {
    EasyLoading.show();

    LoginRepositoryImpl()
        .login(email: email, password: password)
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
}
