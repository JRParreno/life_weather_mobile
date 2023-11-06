import 'package:flutter/material.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';

class JournalBodyContainer extends StatelessWidget {
  const JournalBodyContainer({
    super.key,
    required this.content,
    required this.headerTitle,
    this.isShowViewAll = false,
    this.isEmpty = false,
    this.backgroundColor,
    this.routeName,
  });

  final String headerTitle;
  final Widget content;
  final bool isShowViewAll;
  final bool isEmpty;
  final Color? backgroundColor;
  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorName.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 25,
          )
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: headerTitle,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(fontWeightDelta: 4),
              ),
              if (isShowViewAll && routeName != null) ...[
                CustomTextLink(
                  text: "View All",
                  style: const TextStyle(
                    color: ColorName.placeHolder,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(routeName!);
                  },
                ),
              ]
            ],
          ),
          content,
        ],
      ),
    );
  }
}
