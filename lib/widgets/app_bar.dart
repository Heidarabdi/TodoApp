import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return   ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/programmer.png'),
        backgroundColor: Colors.yellow,
        radius: 25,
      ),
      title: const Text(
        'Hello, I am',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      subtitle: const Text(
        "Mohamed Ahmed",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: PopupMenuButton(
        onSelected: (value) {
          if(value == 'Profile') {
            Navigator.pushNamed(context, '/profile');
          } else if(value == 'Settings'){
            showSnackBar(context, "Coming Soon");
          } else if(value == 'Logout'){
            showSnackBar(context, "Coming Soon");
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'Profile',
            child: Text('Profile'),
          ),
          const PopupMenuItem(
            value: 'Settings',
            child: Text('Settings'),
          ),
          const PopupMenuItem(
            value: 'Logout',
            child: Text('Logout'),
          ),
        ],
        icon: const Icon(
          Icons.more_vert_outlined,
          size: 25,
        ),
      ),

    );
  }
}
