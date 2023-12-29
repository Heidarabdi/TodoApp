import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/models/task_modal.dart';
import 'package:todo_app/service/databse_service.dart';

import '../constant.dart';
import '../utils/get_date.dart';
import '../widgets/get_date.dart';
import '../widgets/get_time.dart';

class BottomSheetModal extends StatefulWidget {
  const BottomSheetModal({super.key});

  @override
  State<BottomSheetModal> createState() => _BottomSheetModalState();
}

class _BottomSheetModalState extends State<BottomSheetModal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // fields controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // title
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'New Task Todo',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Gap(10),
              // line
              const Divider(
                color: CupertinoColors.systemGrey,
                thickness: 1.2,
              ),
              const Gap(10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // title and text field
                  
                        const FieldTitle(title: 'Title Task'),
                  
                        const Gap(10),
                  
                        TextFormField(
                          controller: titleController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter Title',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const Gap(10),
                  
                        // description and text field
                  
                        const FieldTitle(title: 'Description'),
                        const Gap(10),
                  
                        TextFormField(
                          controller: descriptionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          maxLines: 2,
                          decoration: const InputDecoration(
                            hintText: 'Enter Description',
                            border: OutlineInputBorder(),
                          ),
                        ),
                  
                        const Gap(10),
                  
                        // Category and dropdown
                        const FieldTitle(title: 'Category'),
                        const Gap(10),
                  
                        DropdownButtonFormField(
                          value: categoryController.text.isEmpty
                              ? null
                              : categoryController.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Select Category',
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Work',
                              child: Text(
                                'Work',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Personal',
                              child: Text(
                                'Personal',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Meeting',
                              child: Text(
                                'Meeting',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              categoryController.text = value.toString();
                            });
                          },
                        ),
                  
                        const Gap(10),
                  
                        // Category and dropdown
                  
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // date
                  
                            Flexible(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const FieldTitle(title: 'Date'),
                                  const Gap(10),
                                  TextFormField(
                                    controller: dateController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Choose Date';
                                      }
                                      return null;
                                    },
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'DD/MM/YYYY'),
                                    onTap: () {
                                      getDatePicker(context).then((value) {
                                        // filter date
                                        dateController.text = value == null
                                            ? dateController.text
                                            : '${value.day}/${value.month}/${value.year}';
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                  
                            const Gap(10),
                  
                            // time
                  
                            Flexible(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const FieldTitle(title: 'Time'),
                                  const Gap(10),
                                  TextFormField(
                                    controller: timeController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Choose Time';
                                      }
                                      return null;
                                    },
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'HH:MM',
                                    ),
                                    onTap: () {
                                      getTimePicker(context).then((value) {
                                        timeController.text =
                                            value!.format(context);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                  
                        const Gap(20),
                  
                        // cancel and save button
                  
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              title: 'Cancel',
                              isCancel: true,
                            ),
                            CustomButton(
                              onPressed: () async{
                                if (formKey.currentState!.validate()) {
                                  try{
                                    //task modal
                                    TaskModel taskModal = TaskModel(
                                      taskTitle: titleController.text,
                                      taskDesc: descriptionController.text,
                                      taskCat: categoryController.text,
                                      // task create date i want this format 09/09/2021 12:00
                                      taskCreated: getTodayDateTime(),
                                      taskDeadline: '${dateController.text} ${timeController.text}',
                                      isCompleted: false,
                                    );

                                    // add task to firestore
                                    await TaskActions(context: context).addTask(taskModal.toJson());
                                    Navigator.pop(context);




                                  }catch(error){
                                    showSnackBar(context, error.toString());
                                  }
                                }
                              },
                              title: 'Save',
                              isCancel: false,
                            )
                          ],
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ));
  }
}

// custom button
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.isCancel,
  });

  final void Function() onPressed;
  final String title;
  final isCancel;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width * 0.4, 50),
        backgroundColor: isCancel ? Colors.white : const Color(0xff2c60b1),
        // text color
        foregroundColor: isCancel ? Colors.black : Colors.white,
        // border color
        side: BorderSide(
          color: isCancel ? Colors.blue : Colors.transparent,
          width: 2,
        ),

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
      child: Text(title),
    );
  }
}

// field titles
class FieldTitle extends StatelessWidget {
  const FieldTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
