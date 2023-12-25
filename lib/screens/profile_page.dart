import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/constant.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController newPassController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Page'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // photo
              CircleAvatar(
                backgroundImage: Image.network(
                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  filterQuality: FilterQuality.high,
                ).image,
                radius: 100,
              ),

              const Gap(30),
              // name
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    ListileWidget(
                      title: 'Change the name',
                      subtitle: 'Ahmed Mohamed',
                      onTap: () {
                        // pop up dialog to change the name
                        buildShowDialog(context , 'name');
                      },
                    ),

                    const Gap(20),

                    ListileWidget(
                      title: 'Change the email',
                      subtitle: 'ahmedMohamed@gmail.com',
                      onTap: () {
                        // pop up dialog to change the email
                        buildShowDialog(context , 'email');
                      },
                    ),

                    const Gap(20),

                    ListileWidget(
                      title: 'Change the phone number',
                      subtitle: '01111111111',
                      onTap: () {
                        // pop up dialog to change the phone number
                        buildShowDialog(context , 'phone number');
                      },
                    ),

                    const Gap(20),

                    ListileWidget(
                      title: 'Change the password',
                      subtitle: '********',
                      onTap: () {
                        // alert dialog to change the password with old password and new password
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Change the password'),
                                  content:  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: oldPassController,
                                        decoration: const InputDecoration(
                                          hintText: 'Enter your old password',
                                        ),
                                      ),
                                      const Gap(10),
                                      TextField(
                                        controller: newPassController,
                                        decoration: const InputDecoration(
                                          hintText: 'Enter your new password',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel')),
                                    TextButton(
                                        onPressed: () {
                                          if(newPassController.text.compareTo(oldPassController.text) == 0){
                                            // change the password
                                            Navigator.pop(context);
                                            showSnackBar(context, 'Password changed successfully');
                                        }else if(newPassController.text.isEmpty || oldPassController.text.isEmpty){
                                            // show snackbar
                                            showSnackBar(context, 'Please enter your old password and new password');
                                          }else{
                                            // show snackbar
                                           showSnackBar(context, 'Please enter your old password correctly');
                                          }
                                        },
                                        child: const Text('Change')),
                                  ],
                                ));
                      }
                    ),

                    // Delete account

                    const Gap(20),

                    TextButton.icon(
                      onPressed: () {
                        // yes or no
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Are you sure?'),
                                  content: const Text(
                                      'Do you want to delete your account?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);

                                        },
                                        child: const Text('No')),
                                    TextButton(
                                        onPressed: () {
                                          // delete account
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Yes')),
                                  ],
                                ));
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ),
                      label: const Text(
                        'Delete your account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<dynamic> buildShowDialog(BuildContext context , String action) {
    TextEditingController _controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title:  Text('Change the $action'),
              content: TextField(
                controller: _controller,
                decoration:  InputDecoration(
                  hintText: 'Enter your $action',
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        // change the name
                        Navigator.pop(context);
                        showSnackBar(context, '$action changed successfully');
                      } else {
                        // show snackbar
                        showSnackBar(context, 'Please enter your $action');
                      }
                    },
                    child: const Text('Change')),
              ],
            ));
  }
}

class ListileWidget extends StatelessWidget {
  const ListileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
