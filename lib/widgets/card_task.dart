import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/models/task_modal.dart';
import 'package:todo_app/service/databse_service.dart';

import '../constant.dart';

class CardTask extends StatefulWidget {
   CardTask({
    super.key,
    required this.tasks,

  });

  final List<TaskModel> tasks;

  @override
  State<CardTask> createState() => _CardTaskState();
}

class _CardTaskState extends State<CardTask> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),

      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // left side
            Container(
              width: 15,
              height: double.infinity,
              decoration:  BoxDecoration(
                color: widget.tasks[0].taskCat == 'Work' ? Colors.blue :
                widget.tasks[0].taskCat == 'Personal' ? Colors.green :
                widget.tasks[0].taskCat == "Meeting" ? Colors.red :
                Colors.yellow,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),

            // right side
            Expanded(
              flex: 15,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Flexible(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,

                        title:  Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            widget.tasks[0].taskTitle ?? 'Task Title',
                            style:  TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: widget.tasks[0].isCompleted ? TextDecoration.lineThrough : null,
                            ),
                            maxLines: 2,
                          ),
                        ),

                        subtitle:  Text(
                          widget.tasks[0].taskDesc ?? 'Task Description',
                          style:  TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            // if task is completed line through
                            decoration: widget.tasks[0].isCompleted ? TextDecoration.lineThrough : null,



                          )),
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            splashRadius: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            fillColor: widget.tasks[0].isCompleted ? MaterialStateProperty.all(Colors.blue) : MaterialStateProperty.all(Colors.white),
                            value: widget.tasks[0].isCompleted ?? false,
                            onChanged: (value) {
                              try{
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('tasks')
                                    .doc(widget.tasks[0].taskId)
                                    .update({'isCompleted': value});
                              }catch(error) {
                                showSnackBar(context, error.toString());
                              }
                            },
                          ),),
                      ),
                    ),


                    const Gap(1),

                     const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),


                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // type of task
                        Text(
                          widget.tasks[0].taskCat ?? 'Task Type',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Created at ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.tasks[0].taskCreated ?? 'Task Created At',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ]
                            ),
                            Row(
                                children: [
                                  const Text(
                                    "Deadline ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.tasks[0].taskDeadline ?? 'Task Deadline',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                ]
                            ),
                          ],

                        )
                      ],
                    )

                  ],


                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

