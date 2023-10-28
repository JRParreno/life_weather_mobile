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
  });

  final String headerTitle;
  final Widget content;
  final bool isShowViewAll;
  final bool isEmpty;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      constraints: isEmpty
          ? null
          : BoxConstraints(
              maxHeight: height * 0.4,
              minHeight: height * 0.2,
            ),
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorName.white,
        border: Border.all(
          color: ColorName.placeHolder,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CustomText(
                text: headerTitle,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(fontWeightDelta: 4),
              ),
              if (isShowViewAll) ...[
                CustomTextLink(
                  text: "View All",
                  style: const TextStyle(
                    color: ColorName.placeHolder,
                  ),
                  onTap: () => {},
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
