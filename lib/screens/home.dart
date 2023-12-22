import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:todo_app/widgets/bottom_sheet.dart';

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
        backgroundColor: Colors.white,
        // elevation: 0,
        automaticallyImplyLeading: false,
        title:  ListTile(
          leading: CircleAvatar(
            backgroundImage: Image.asset(
              'assets/images/programmer.png',
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ).image,
            backgroundColor: Colors.yellow,
            radius: 25,
          ),
          title: const Text(
            'Hello,',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.settings,
                color: Colors.black,
                size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.sort_down, color: Colors.black,size: 30,),
          ),
        ],
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
                          horizontal: 20, vertical: 14
                      ),
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
