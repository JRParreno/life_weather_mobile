import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';

class WeatherDate extends StatelessWidget {
  const WeatherDate({
    super.key,
    required this.date,
    this.axis = Axis.horizontal,
    required this.textColor,
  });

  final DateTime date;
  final Axis axis;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (axis == Axis.horizontal) {
      return Row(
        children: [
          CustomText(
            text: DateFormat.E().format(date),
            style: textTheme.bodyMedium!.apply(
              fontWeightDelta: 4,
              color: textColor.withOpacity(0.65),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CustomText(
            text: DateFormat('dd').format(date),
            style: textTheme.bodyMedium!.apply(
              fontWeightDelta: 4,
              color: textColor.withOpacity(0.65),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: DateFormat.E().format(date),
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        CustomText(
          text: DateFormat('MMM dd, yyyy').format(date),
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
