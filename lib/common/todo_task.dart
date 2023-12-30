import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/common/bottom_sheet.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/models/task_modal.dart';
import 'package:todo_app/service/databse_service.dart';

import '../widgets/card_task.dart';
import '../widgets/action_card.dart';

class TodoList extends StatefulWidget {
   const TodoList({super.key,required this.whichSortIsSelected});
  final String whichSortIsSelected;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  Stream<QuerySnapshot> getData() {
    if (widget.whichSortIsSelected == 'Uncompleted') {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks')
          .where('isCompleted', isEqualTo: false)
          .snapshots();
    } else if (widget.whichSortIsSelected == 'Completed') {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks')
          .where('isCompleted', isEqualTo: true)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks')
          .snapshots();

    }
  }




  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getData(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.lightBlueAccent,
            ),
          );
        } else {
          List<TaskModel> task = snapshot.data!.docs.map((e) {
            return TaskModel(
              taskId: e.id,
              taskTitle: e['taskTitle'],
              taskDesc: e['taskDesc'],
              taskCat: e['taskCat'],
              taskCreated: e['taskCreated'],
              taskDeadline: e['taskDeadline'],
              isCompleted: e['isCompleted'],
            );
          }).toList();
          return ListView.builder(
          itemCount: snapshot.data!.docs.length,
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
                  try{
                  if (direction == DismissDirection.startToEnd) {
                    // delete
                    TaskActions(context: context).deleteTask(task[index].taskId!);
                  } else {
                    // edit
                    showModalBottomSheet(
                        isDismissible: false,
                        isScrollControlled: true,

                        // showDragHandle: true,
                        context: context,
                        builder: (context) =>  BottomSheetModal(
                          taskId: task[index].taskId,
                          task: task[index],

                        ));
                  }
                }catch(e){
                    showSnackBar(context, e.toString());
                  }
                },
                child:   CardTask(
                  tasks: [task[index]],
                ));
          },
        );
        }
      },
    );
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
