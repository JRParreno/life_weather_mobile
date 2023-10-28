import 'package:flutter/material.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog(
      {super.key,
      this.onTapCancel,
      required this.onTapOk,
      required this.title});

  final VoidCallback? onTapCancel;
  final VoidCallback onTapOk;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomBtn(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        handleDialog(context);
      },
      label: 'Delete',
      backgroundColor: ColorName.error,
    );
  }

  void handleDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const CustomText(text: 'Todo'),
        content: CustomText(text: 'Delete this $title?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => onTapCancel ?? Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onTapOk();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
