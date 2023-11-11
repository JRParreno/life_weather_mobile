import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:ndialog/ndialog.dart';
import 'package:life_weather_mobile/src/core/config/app_constant.dart';
import 'package:life_weather_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:life_weather_mobile/src/features/account/profile/presentation/widgets/change_password/password_form.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = 'change-password';
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController passwordConfirmCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _passwordConfirmVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: "Change Password",
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
        child: Column(
          children: [
            PasswordForm(
              formKey: formKey,
              oldPasswordCtrl: oldPasswordCtrl,
              passwordConfirmCtrl: passwordConfirmCtrl,
              passwordCtrl: passwordCtrl,
              onSubmit: handleSubmit,
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

  void handleSubmit() {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      if (passwordConfirmCtrl.text == passwordCtrl.text) {
        ProfileRepositoryImpl()
            .changePassword(
                oldPassword: oldPasswordCtrl.text,
                newPassword: passwordCtrl.text)
            .then((value) {
          showDialogReport("Successfully change your password!");
          passwordConfirmCtrl.text = "";
          passwordCtrl.text = "";
          oldPasswordCtrl.text = "";
          formKey.currentState!.reset();
        }).catchError((onError) {
          EasyLoading.dismiss();
          final DioException error = onError as DioException;
          if (error.response != null) {
            final response = error.response!.data;
            showDialogReport(response['error_message']);
          }
        }).whenComplete(() {
          EasyLoading.dismiss();
        });
      } else {
        EasyLoading.dismiss();
        showDialogReport("Password and Confirm password doesn't match");
      }
    }
  }

  void showDialogReport(String message) {
    Future.delayed(const Duration(milliseconds: 500), () {
      NDialog(
        dialogStyle: DialogStyle(titleDivider: true),
        title: const CustomText(text: AppConstant.appName),
        content: CustomText(text: message),
        actions: <Widget>[
          TextButton(
              child: const CustomText(text: "Close"),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ).show(context);
    });
  }

  void handleOnConfirmChangePassVisible() {
    setState(() {
      _passwordConfirmVisible = !_passwordConfirmVisible;
    });
  }

  void handleOnChangePassVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
