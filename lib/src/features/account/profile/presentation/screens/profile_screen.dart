import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:life_weather_mobile/src/core/utils/profile_utils.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:life_weather_mobile/src/features/account/profile/presentation/screens/change_password_screen.dart';
import 'package:life_weather_mobile/src/features/account/profile/presentation/screens/update_account_screen.dart';
import 'package:life_weather_mobile/src/features/account/profile/presentation/screens/update_profile_picture_screen.dart';
import 'package:life_weather_mobile/src/features/account/profile/presentation/widgets/review_report/review_report_form.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController reviewCtrl = TextEditingController();
  final TextEditingController reportCtrl = TextEditingController();

  Profile? profile;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => initProfile());
    super.initState();
  }

  void initProfile() {
    setState(() {
      profile = ProfileUtils.userProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = ProfileUtils.userProfile(context);

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Profile',
        backgroundColor: const Color(0xff38b6ff).withOpacity(1),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover),
        ),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: const Alignment(1, 1),
              colors: <Color>[
                const Color(0xff38b6ff).withOpacity(1),
                const Color(0xff38b6ff).withOpacity(0.25),
              ], // Gradient from https://learnui.design/tools/gradient-generator.html
              tileMode: TileMode.mirror,
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.white),
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const CustomText(
                    text: 'User Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoaded) {
                            return SizedBox(
                              height: 115,
                              width: 115,
                              child: Stack(
                                clipBehavior: Clip.none,
                                fit: StackFit.expand,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        state.profile?.profilePhoto != null
                                            ? NetworkImage(
                                                state.profile!.profilePhoto!)
                                            : null,
                                    radius: 50,
                                    child: state.profile?.profilePhoto != null
                                        ? null
                                        : const Icon(Icons.person, size: 50),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: -25,
                                      child: RawMaterialButton(
                                        onPressed: () {
                                          handleNavigateUploadPicture();
                                        },
                                        elevation: 2.0,
                                        fillColor: const Color(0xFFF5F6F9),
                                        padding: const EdgeInsets.all(15.0),
                                        shape: const CircleBorder(),
                                        child: const Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.blue,
                                        ),
                                      )),
                                ],
                              ),
                            );
                          }

                          return const SizedBox();
                        },
                      )),
                  CustomText(
                    text: '${profile?.firstName} ${profile?.lastName}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: handleNavigateEditProfile,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: CustomText(
                        text: 'Click to edit profile',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 3,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomText(
                          text: 'Account Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomText(
                          text: profile?.email ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomText(
                          text: profile?.contactNumber ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Reviews & Reports',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ReviewReportForm(
                          reviewCtrl: reviewCtrl,
                          reportCtrl: reportCtrl,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  GestureDetector(
                    onTap: handleNavigateChangePassword,
                    child: const SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Change Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'About us',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleNavigateEditProfile() {
    Navigator.of(context).pushNamed(UpdateAccountScreen.routeName);
  }

  void handleNavigateChangePassword() {
    Navigator.of(context).pushNamed(ChangePasswordScreen.routeName);
  }

  void handleNavigateUploadPicture() {
    Navigator.of(context).pushNamed(UpdateProfilePcitureScreen.routeName);
  }
}
