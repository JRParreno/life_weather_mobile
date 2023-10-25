import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';

class ReviewReportForm extends StatelessWidget {
  const ReviewReportForm({
    super.key,
    required this.reviewCtrl,
    required this.reportCtrl,
  });

  final TextEditingController reviewCtrl;
  final TextEditingController reportCtrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFFE6E6E6),
            ),
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const CustomText(text: 'Reviews'),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        labelText: '',
                        textController: reviewCtrl,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.send),
                const SizedBox(
                  width: 5,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFFE6E6E6),
            ),
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const CustomText(text: 'Report bug and issues'),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        labelText: '',
                        textController: reviewCtrl,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.send),
                const SizedBox(
                  width: 5,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
