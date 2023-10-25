import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ndialog/ndialog.dart';
import 'package:life_weather_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/core/config/app_constant.dart';
import 'package:life_weather_mobile/src/core/utils/profile_utils.dart';
import 'package:life_weather_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:life_weather_mobile/src/features/account/profile/presentation/widgets/update_account/update_account_form.dart';

class UpdateAccountScreen extends StatefulWidget {
  static const String routeName = 'update-account';

  const UpdateAccountScreen({super.key});

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController mobileNoCtrl = TextEditingController();
  final TextEditingController completeAddressCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController firstNameCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String linkTitle = "You account is not verified yet. click here to verify.";
  String gender = '';

  @override
  void initState() {
    setUpForm();
    super.initState();
  }

  void setUpForm() {
    final profile = ProfileUtils.userProfile(context);
    if (profile != null) {
      emailCtrl.text = profile.email;
      mobileNoCtrl.text = profile.contactNumber;
      completeAddressCtrl.text = profile.address;
      lastNameCtrl.text = profile.lastName;
      firstNameCtrl.text = profile.firstName;
      gender = profile.gender;
    }
  }

  void handleSubmit() {
    if (formKey.currentState!.validate() && gender.isNotEmpty) {
      EasyLoading.show();
      ProfileRepositoryImpl()
          .updateProfile(
        address: completeAddressCtrl.text,
        contactNumber: mobileNoCtrl.text,
        email: emailCtrl.text,
        firstName: firstNameCtrl.text,
        lastName: lastNameCtrl.text,
        gender: gender,
      )
          .then((value) {
        BlocProvider.of<ProfileBloc>(context)
            .add(SetProfileEvent(profile: value));
        showDialogReport("Successfully udpate your account!");
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

  @override
  Widget build(BuildContext context) {
    final profile = ProfileUtils.userProfile(context);

    return Scaffold(
      appBar: buildAppBar(context: context, title: "Account"),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UpdateAccountForm(
                completeAddressCtrl: completeAddressCtrl,
                emailCtrl: emailCtrl,
                mobileNoCtrl: mobileNoCtrl,
                lastNameCtrl: lastNameCtrl,
                firstNameCtrl: firstNameCtrl,
                formKey: formKey,
                onSubmit: handleSubmit,
                gender: gender.isNotEmpty ? gender : profile?.gender ?? '',
                onSelect: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
