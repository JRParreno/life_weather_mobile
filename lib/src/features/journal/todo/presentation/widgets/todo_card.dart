import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/journal/todo/data/models/todo_model.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.todoModel,
  }) : super(key: key);

  final TodoModel todoModel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: todoModel.title,
                  style: textTheme.titleMedium,
                ),
                Vspace.xs,
                CustomText(
                  text: formattedDate(
                    todoModel.dateCreated,
                  ),
                  style: textTheme.labelSmall,
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: getStatusColor(todoModel.status),
              ),
              child: CustomText(
                text: todoModel.status,
                style: textTheme.labelSmall!
                    .apply(color: Colors.white, fontSizeFactor: 1),
              ),
            )
          ],
        ),
      ),
    );
  }

  String formattedDate(String dateCreated) {
    final f = DateFormat('MMM dd yyyy');

    return f.format(DateTime.parse(dateCreated));
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'TODO':
        return Colors.blue;
      case 'ON PROCESS':
        return Colors.red;
      default:
        return Colors.pink;
    }
  }
}
