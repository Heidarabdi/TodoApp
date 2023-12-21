import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BottomSheetModal extends StatefulWidget {
  const BottomSheetModal({super.key});

  @override
  State<BottomSheetModal> createState() => _BottomSheetModalState();
}

class _BottomSheetModalState extends State<BottomSheetModal> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.70,
        decoration: const BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            child: Column(children: [
              // title
              const Text(
                'New Task Todo',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(10),
              // divider
              const Divider(
                color: CupertinoColors.systemGrey,
                thickness: 1.2,
              ),

              const Gap(20),

              // title and textfeild

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Title Task',
                  style: _textStyle,
                ),
              ),

              const Gap(10),

              TextFormField(
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

              // description and textfeild

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Description',
                  style: _textStyle,
                ),
              ),

              const Gap(10),

              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Enter Description',
                  border: OutlineInputBorder(),
                ),
              ),

              const Gap(10),

              // Category and dropdown

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Category',
                          style: _textStyle,
                        ),
                      ),
                      const Gap(10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              child: Text('Work'),
                              value: 'Work',
                            ),
                            DropdownMenuItem(
                              child: Text('Personal'),
                              value: 'Personal',
                            ),
                            DropdownMenuItem(
                              child: Text('Meeting'),
                              value: 'Meeting',
                            ),
                          ],
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                      ),
                    ],
                  ),

                  // date

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Date',
                          style: _textStyle,
                        ),
                      ),
                      const Gap(10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          readOnly: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'DD/MM/YYYY'),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2025),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  // time

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Time',
                          style: _textStyle,
                        ),
                      ),
                      const Gap(10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.20,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'HH:MM',
                          ),
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}

// make one text to use multiple times
const _textStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
