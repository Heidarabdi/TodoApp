import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/card_task.dart';
import '../widgets/action_card.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          // Card_Task
          return Dismissible(
              key: UniqueKey(),
              background: const ActionCard(
                color: Colors.red,
                icon: Icons.delete,
                text: 'Delete',
              ),
              secondaryBackground: const ActionCard(
                color: Colors.green,
                icon: Icons.edit,
                text: 'Edit',
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return buildAlertDialog(context, 'Delete');
                    },
                  );
                } else {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return buildAlertDialog(context, 'Edit');
                    },
                  );
                }
              },
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                } else {
                  // edit
                }
              },
              child: const CardTask());
        });
  }

  AlertDialog buildAlertDialog(BuildContext context, String action) {
    return AlertDialog(
      title: Text("$action Confirmation"),
      content: Text("Are you sure you want to $action this note?"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(action),
        ),
      ],
    );
  }
}
