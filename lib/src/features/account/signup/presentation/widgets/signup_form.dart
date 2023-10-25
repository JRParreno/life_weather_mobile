import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/account/signup/presentation/widgets/gender_select_widget.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.confirmPasswordCtrl,
    required this.mobileNoCtrl,
    required this.completeAddressCtrl,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.formKey,
    required this.suffixIcon,
    required this.passwordVisible,
    required this.onSubmit,
    required this.confirmPasswordVisible,
    required this.confirmSuffixIcon,
    required this.genderCtrl,
    required this.onSelectGender,
  });

  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPasswordCtrl;
  final TextEditingController mobileNoCtrl;
  final TextEditingController completeAddressCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController firstNameCtrl;
  final TextEditingController genderCtrl;
  final Function(String value) onSelectGender;

  final GlobalKey<FormState> formKey;
  final Widget suffixIcon;
  final bool passwordVisible;
  final Widget confirmSuffixIcon;
  final bool confirmPasswordVisible;

  final VoidCallback onSubmit;

  String? regexTest({
    required RegExp regex,
    required String value,
    required errorText,
  }) {
    final sames = value.isEmpty
        ? "Required"
        : regex.hasMatch(value)
            ? null
            : errorText;
    return sames;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Divider(
                color: Colors.transparent,
                height: 20,
              ),
              CustomTextField(
                textController: firstNameCtrl,
                labelText: "First Name",
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              CustomTextField(
                textController: lastNameCtrl,
                labelText: "Last Name",
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              CustomTextField(
                textController: genderCtrl,
                labelText: "Gender",
                keyboardType: TextInputType.emailAddress,
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
                readOnly: true,
                onTap: () => commonBottomSheetDialog(
                  context: context,
                  title: "Select Gender",
                  container: GenderSelectWidget(
                    onSelectGender: onSelectGender,
                    selectedGender:
                        genderCtrl.text.isNotEmpty ? genderCtrl.text : null,
                  ),
                ),
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              CustomTextField(
                textController: emailCtrl,
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
                validators: (value) {
                  if (value != null &&
                      RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w\w+)+$')
                          .hasMatch(value)) {
                    return null;
                  }
                  return 'Invalid email address';
                },
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              CustomTextField(
                textController: mobileNoCtrl,
                labelText: "Mobile number",
                keyboardType: TextInputType.emailAddress,
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
                validators: (value) {
                  if (value != null &&
                      RegExp(r'^(09|\+639)\d{9}$').hasMatch(value)) {
                    return null;
                  }
                  return 'Invalid mobile number';
                },
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              CustomTextField(
                textController: completeAddressCtrl,
                labelText: "Complete Address",
                keyboardType: TextInputType.emailAddress,
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              CustomTextField(
                textController: passwordCtrl,
                labelText: "Password",
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
                suffixIcon: suffixIcon,
                obscureText: passwordVisible,
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              CustomTextField(
                textController: confirmPasswordCtrl,
                labelText: "Confirm Password",
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
                suffixIcon: confirmSuffixIcon,
                obscureText: confirmPasswordVisible,
                validators: (value) {
                  if (value != null && value.isEmpty ||
                      value != passwordCtrl.value.text) {
                    return "Password doesn't match";
                  }
                  return null;
                },
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
            ],
          ),
          const Divider(
            height: 15,
            color: Colors.transparent,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomBtn(
                label: "Signup",
                onTap: onSubmit,
                width: 275,
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
            ],
          )
        ],
      ),
    );
  }
}
