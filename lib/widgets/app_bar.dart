import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/service/user_auth.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
    required this.name,
    required this.profileUrl,
  });

  final String name;
  final String profileUrl;


  @override
  Widget build(BuildContext context) {


    return   ListTile(
      contentPadding: EdgeInsets.zero,
      leading:  CircleAvatar(
        backgroundImage: (profileUrl != null || profileUrl!= '') ? NetworkImage(profileUrl):
        const AssetImage('assets/images/programmer.png') as ImageProvider,
        backgroundColor: Colors.yellow,
        radius: 25,
      ),
      title: const Text(
        'Hello, I am',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      subtitle:  Text(
        name?? 'User',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: PopupMenuButton(
        onSelected: (value) async {
          if(value == 'Profile') {
            Navigator.pushNamed(context, '/profile');
          } else if(value == 'Settings'){
            showSnackBar(context, "Coming Soon");
          } else if(value == 'Logout'){
            var result = FireAuth.signOut(context: context);
            result != null ? Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false)
                : showSnackBar(context, "Error");

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
