import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:todo_app/widgets/bottom_sheet.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellow,
                radius: 40,
                child: Image.asset(
                  'assets/images/programmer.png',
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text(
                "Hello I'm",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: const Text(
                'Mohamed Osman',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.calendar_today,
                  color: Colors.black),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.bell, color: Colors.black),
            ),
          ],
        ),
      ),

      // body with green background
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
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
                        'Today, 21 July',
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
                          context: context,
                          builder: (context) => const BottomSheetModal());
                    },
                    icon: const Icon(
                      CupertinoIcons.add,
                      size: 16,
                    ),
                    label: const Text('New Task',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    style: ElevatedButton.styleFrom(
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
            ],
          ),
        ),
      ),
    );
  }
}
