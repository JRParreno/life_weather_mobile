import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';

class StatusSelectWidget extends StatelessWidget {
  const StatusSelectWidget({
    super.key,
    this.selectedStatus,
    required this.onSelectStatus,
  });

  final String? selectedStatus;
  final Function(String value) onSelectStatus;

  @override
  Widget build(BuildContext context) {
    final selection = ['TODO', 'ON PROCESS', 'DONE', 'CANCELLED', 'ARCHIVED'];

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
                  if (selection[index] == selectedStatus) ...[
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
    onSelectStatus(value);
    Navigator.pop(context);
  }
}
