import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:todo_app/models/bottom_sheet.dart';
import 'package:todo_app/models/todo_task.dart';

import '../utils/get_date.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/programmer.png'),
                backgroundColor: Colors.yellow,
                radius: 25,
              ),
              title: Text(
                'Hello, I am',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                "Mohamed Ahmed",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing:
              Row(
                mainAxisSize: MainAxisSize.min,
                  children: [
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.sort,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ]),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                        fontSize: 30,
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
                        horizontal: 20, vertical: 14),
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

            // TodoList
            const Expanded(
              child: TodoList(),
            ),
          ],
        ),
      ),
    );
  }
}
