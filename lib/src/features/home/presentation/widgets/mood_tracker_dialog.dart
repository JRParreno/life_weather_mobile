import 'package:flutter/material.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';

Future<void> moodTrackerDialog({
  required BuildContext context,
  required Function(String) onSelect,
  String? preSelect,
}) {
  List<List<String>> getEmojis() {
    final emojis = [
      ['😜', '😀', '😁', '😂'],
      ['😄', '😅', '😆', '😇'],
      ['😈', '😉', '😊', '😍'],
      ['😎', '😏', '😐', '😑'],
      ['😒', '😓', '😔', '😕'],
    ];

    return emojis;
  }

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      String? selected;

      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          backgroundColor: ColorName.white,
          title: const Text('Please select your mood'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: getEmojis().length,
                  itemBuilder: (context, parentIndex) {
                    final parentItem = getEmojis()[parentIndex];

                    return SizedBox(
                      width: double.maxFinite,
                      height: 80,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (String item in parentItem) ...[
                            GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    selected = item;
                                  },
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: item == selected
                                    ? ColorName.primary
                                    : ColorName.white,
                                child: Text(
                                  item,
                                  style: const TextStyle(fontSize: 30),
                                ),
                              ),
                            )
                          ]
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          actions: <Widget>[
            if (selected != null) ...[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Set mood'),
                onPressed: () {
                  onSelect(selected!);
                  Navigator.of(context).pop();
                },
              ),
            ]
          ],
        );
      });
    },
  );
}
