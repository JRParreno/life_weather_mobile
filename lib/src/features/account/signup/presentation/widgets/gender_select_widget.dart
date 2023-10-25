import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';

class GenderSelectWidget extends StatelessWidget {
  const GenderSelectWidget({
    super.key,
    this.selectedGender,
    required this.onSelectGender,
  });

  final String? selectedGender;
  final Function(String value) onSelectGender;

  @override
  Widget build(BuildContext context) {
    final selection = ['Male', 'Female'];

    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: selection.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () =>
              onTapSelectClose(context: context, value: selection[index]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: selection[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  if (selection[index] == selectedGender) ...[
                    const Icon(Icons.check),
                  ]
                ],
              ),
              const Divider(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapSelectClose({
    required BuildContext context,
    required String value,
  }) {
    onSelectGender(value);
    Navigator.pop(context);
  }
}
