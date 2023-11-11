import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/account/signup/presentation/widgets/gender_select_widget.dart';

class UpdateAccountForm extends StatelessWidget {
  const UpdateAccountForm({
    super.key,
    required this.emailCtrl,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.genderCtrl,
    required this.formKey,
    required this.onSubmit,
    required this.onSelectGender,
  });

  final TextEditingController emailCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController firstNameCtrl;
  final TextEditingController genderCtrl;
  final Function(String value) onSelectGender;

  final GlobalKey<FormState> formKey;

  final VoidCallback onSubmit;

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
            ],
          ),
          const Divider(
            height: 30,
            color: Colors.transparent,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomBtn(
                label: "Submit",
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
