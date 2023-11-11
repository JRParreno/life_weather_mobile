import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/core/utils/profile_utils.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/account/profile/presentation/screens/change_password_screen.dart';
import 'package:life_weather_mobile/src/features/account/profile/presentation/screens/update_account_screen.dart';

class MenuOptions extends StatelessWidget {
  final BuildContext ctx;
  const MenuOptions({super.key, required this.ctx});

  void navigate({required BuildContext context, required String routeName}) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const CustomText(text: 'Account Settings'),
          leading: const Icon(Icons.person),
          onTap: () {
            navigate(
              context: context,
              routeName: UpdateAccountScreen.routeName,
            );
          },
          trailing: const Icon(Icons.chevron_right),
          enableFeedback: true,
        ),
        const Divider(
          height: 0,
          color: Colors.black,
        ),
        ListTile(
          title: const CustomText(text: 'Change Password'),
          leading: const Icon(Icons.password),
          onTap: () {
            navigate(
              context: context,
              routeName: ChangePasswordScreen.routeName,
            );
          },
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(
          height: 0,
          color: Colors.black,
        ),
        ListTile(
          title: const CustomText(text: 'Terms and Condition'),
          leading: const Icon(Icons.security),
          onTap: () {},
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(
          height: 0,
          color: Colors.black,
        ),
        ListTile(
          title: const CustomText(text: 'Privacy Policy'),
          leading: const Icon(Icons.fingerprint),
          onTap: () {},
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(
          height: 0,
          color: Colors.black,
        ),
        ListTile(
          title: const CustomText(text: 'Help'),
          leading: const Icon(Icons.help),
          onTap: () {},
          trailing: const Icon(Icons.chevron_right),
        ),
        const Divider(
          height: 0,
          color: Colors.black,
        ),
        ListTile(
          title: const CustomText(text: 'Logout'),
          leading: const Icon(Icons.logout),
          onTap: () async {
            ProfileUtils.handleLogout(context);
          },
        ),
        const Divider(
          height: 0,
          color: Colors.black,
        ),
      ],
    );
  }
}
