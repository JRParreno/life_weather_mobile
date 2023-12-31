import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/config/app_constant.dart';

PreferredSizeWidget buildAppBar({
  required BuildContext context,
  String? title,
  Widget? leading,
  bool showBackBtn = false,
  List<Widget>? actions,
  Color? backgroundColor,
  Widget? titleWidget,
  double elevation = 0,
  bool isDarkMode = false,
}) {
  return AppBar(
    toolbarHeight: kToolbarHeight,
    titleSpacing: 0,
    backgroundColor: backgroundColor ?? ColorName.primary,
    centerTitle: titleWidget != null ? false : true,
    elevation: elevation,
    automaticallyImplyLeading: false,
    leading: !showBackBtn
        ? leading ??
            IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: 40,
                color: !isDarkMode ? Colors.white : Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
        : null,
    title: titleWidget ??
        Text(
          title ?? AppConstant.appName,
          style: TextStyle(
            color: !isDarkMode ? Colors.black : Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: .3,
          ),
        ),
    actions: actions,
  );
}
