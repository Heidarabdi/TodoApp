import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:todo_app/common/bottom_sheet.dart';
import 'package:todo_app/widgets/app_bar.dart';

import '../common/todo_task.dart';
import '../utils/get_date.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<String> whichSortIsSelected = ValueNotifier<String>('All');


  @override
  Widget build(BuildContext context) {
    print('HomeScreen builddddddddddinggggggggggggg');
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks').
          snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else {
          String length = snapshot.data!.docs.length.toString();
          String completed = snapshot.data!.docs.where((element) => element['isCompleted'] == true).length.toString();
          String uncompleted = snapshot.data!.docs.where((element) => element['isCompleted'] == false).length.toString();

          return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          // elevation: 0,
          automaticallyImplyLeading: false,
          title:  const Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: AppbarWidget()),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Tasks',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // date
                      Text(
                        getTodayDate(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  //new task button
                  ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                          isDismissible: false,
                          isScrollControlled: true,

                          // showDragHandle: true,
                          context: context,
                          builder: (context) => const BottomSheetModal());
                    },
                    icon: const Icon(
                      CupertinoIcons.add,
                      size: 18,
                    ),
                    label: const Text('New Task',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      backgroundColor: const Color(0xffd9e6f5),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const Gap(10),

              // sort by like (all, completed, uncompleted) button text with badges (0, 0, 0)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        whichSortIsSelected.value = 'All';
                      },
                      child: buildRow('All', length),
                    ),
                    TextButton(
                      onPressed: () {
                        whichSortIsSelected.value = 'Completed';

                      },
                      child: buildRow('Completed', completed),

                    ),
                    TextButton(
                      onPressed: () {
                          whichSortIsSelected.value = 'Uncompleted';
                      },
                      child: buildRow('Uncompleted', uncompleted),
                    ),
                  ],
                ),
              ),

              const Gap(10),
              // TodoList
               ValueListenableBuilder(
                  valueListenable: whichSortIsSelected,
                  builder: (context, value, child) {
                 return Expanded(
                  child: TodoList(
                    whichSortIsSelected: value,
                  ),
                );
                  }
                ),
            ],
          ),
        ),
      );
        }
      }
    );
  }
  ValueListenableBuilder<String> buildRow(String text, String number) {
    return ValueListenableBuilder(
      valueListenable: whichSortIsSelected,
      builder: (context, value, child) {
        return Row(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: value == text ? Colors.blue : Colors.grey[700],
              ),
            ),
            const Gap(5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
              decoration: BoxDecoration(
                color: value == text ? Colors.blue : Colors.grey[500],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color:
                  value == text ? Colors.white : Colors.white70,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}



