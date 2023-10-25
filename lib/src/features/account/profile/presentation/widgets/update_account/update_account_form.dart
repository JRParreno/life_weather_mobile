import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';

class UpdateAccountForm extends StatelessWidget {
  final TextEditingController emailCtrl;
  final TextEditingController mobileNoCtrl;
  final TextEditingController completeAddressCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController firstNameCtrl;
  final String gender;
  final Function(String value) onSelect;

  final GlobalKey<FormState> formKey;

  final VoidCallback onSubmit;

  const UpdateAccountForm({
    super.key,
    required this.emailCtrl,
    required this.mobileNoCtrl,
    required this.completeAddressCtrl,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.formKey,
    required this.onSubmit,
    required this.gender,
    required this.onSelect,
  });

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
                textController: mobileNoCtrl,
                labelText: "Mobile number",
                keyboardType: TextInputType.number,
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
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: CustomText(text: 'Gender'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: const Text("Male"),
                            value: 'M',
                            groupValue: gender,
                            onChanged: (value) {
                              onSelect('M');
                            },
                            selected: gender == 'M',
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text("Female"),
                            value: 'F',
                            groupValue: gender,
                            onChanged: (value) {
                              onSelect('F');
                            },
                            selected: gender == 'F',
                            contentPadding: EdgeInsets.zero,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
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
