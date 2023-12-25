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
  String whichSortIsSelected = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        // elevation: 0,
        automaticallyImplyLeading: false,
        title: const Padding(
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        whichSortIsSelected = 'All';
                      });
                    },
                    child: buildRow('All', '1500'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        whichSortIsSelected = 'Completed';
                      });
                    },
                    child: buildRow('Completed', '99'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        whichSortIsSelected = 'Uncompleted';
                      });
                    },
                    child: buildRow('Uncompleted', '99'),
                  ),
                ],
              ),
            ),

            const Gap(10),
            // TodoList
            const Expanded(
              child: TodoList(),
            ),
          ],
        ),
      ),
    );
  }

  Row buildRow(String text, String number) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: whichSortIsSelected == text ? Colors.blue : Colors.grey[700],
          ),
        ),
        const Gap(5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
          decoration: BoxDecoration(
            color: whichSortIsSelected == text ? Colors.blue : Colors.grey[500],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            number,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color:
                  whichSortIsSelected == text ? Colors.white : Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}
