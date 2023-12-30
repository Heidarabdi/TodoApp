import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/service/databse_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController newPassController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _id = FirebaseAuth.instance.currentUser!.uid;
  // List<Map<String, dynamic>> data = [];
  //
  // Future<void> getData() async {
  //   try {
  //     await _firestore.collection('users').doc(_id).get().then((value) {
  //       data.add(value.data()!);
  //     });
  //   } catch (e) {
  //     print(e);
  //     showSnackBar(context, e.toString());
  //   }
  // }

  // image picker code
  final ImagePicker _picker = ImagePicker();
  File? _image;
  chooseImages() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image
            .path); //this will make tghe fn not null and galary will be opened
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Page'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('users').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var data = snapshot.data!.docs.where((element) => element.id == _id).toList();
              bool isGoogleUser = FirebaseAuth.instance.currentUser!.providerData[0].providerId == 'google.com';
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: (data[0]['profileUrl'] == null || data[0]['profileUrl'] == '')
                              ? const AssetImage('assets/images/user.png') as ImageProvider
                              : CachedNetworkImageProvider(data[0]['profileUrl']),

                          backgroundColor: Colors.yellowAccent,
                          radius: 100,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 10,
                          child: IconButton(
                            onPressed: () async {
                              // change the photo
                              try{
                                await chooseImages();
                                if(_image != null){
                                  // upload the image to firebase storage
                                  var storageRef = FirebaseStorage.instance
                                      .ref()
                                      .child('profile')
                                      .child(_id);
                                  var uploadTask = storageRef.putFile(_image!);
                                  var url = await (await uploadTask).ref.getDownloadURL(); //
                                  await _firestore.collection('users').doc(_id).update({
                                    'profileUrl': url,
                                  });
                                  setState(() {});


                                }

                              }catch(e){
                                showSnackBar(context, e.toString());
                              }
                            },
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.red,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Gap(30),
                    // name
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          ListileWidget(
                            title: 'Change the name',
                            subtitle: data[0]['fullname'] ?? "no name",
                            onTap: () {
                              // pop up dialog to change the name
                              buildShowDialog(context, 'fullname');
                            },
                          ),

                          const Gap(20),

                          ListileWidget(
                            title: 'Change the email',
                            subtitle: data[0]['email'] ?? "no email",
                            onTap: () {
                              // pop up dialog to change the email
                              buildShowDialog(context, 'email');
                            },
                          ),

                          const Gap(20),

                          ListileWidget(
                            title: 'Change the phone number',
                            subtitle: data[0]['phone'] ?? "no phone",
                            onTap: () {
                              // pop up dialog to change the phone number
                              buildShowDialog(context, 'phone');
                            },
                          ),

                          const Gap(20),
                          // if the user is google user then hide the password change option
                              isGoogleUser
                              ? const SizedBox()
                              :
                          ListileWidget(
                              title: 'Change the password',
                              subtitle: '********',
                              onTap: () {
                                // alert dialog to change the password with old password and new password
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title:
                                              const Text('Change the password'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                controller: oldPassController,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText:
                                                      'Enter your old password',
                                                ),
                                              ),
                                              const Gap(10),
                                              TextField(
                                                controller: newPassController,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText:
                                                      'Enter your new password',
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
                                                onPressed: () async {
                                                  try {
                                                    if (newPassController
                                                            .text.isNotEmpty &&
                                                        oldPassController
                                                            .text.isNotEmpty) {
                                                      // change the password
                                                      await ProfileActions(
                                                              context: context)
                                                          .updatePassword(
                                                              newPassController
                                                                  .text,
                                                              oldPassController
                                                                  .text);
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                    } else {
                                                      showSnackBar(context,
                                                          'Please enter your password');
                                                    }
                                                  } catch (e) {
                                                    showSnackBar(
                                                        context, e.toString());
                                                  }
                                                },
                                                child: const Text('Change')),
                                          ],
                                        ));
                              }),

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
                                              onPressed: () async {
                                                // delete account
                                                // try {
                                                //  await ProfileActions(
                                                //           context: context)
                                                //       .deleteUser();
                                                //   Navigator.pop(context);
                                                //   Navigator.pushNamedAndRemoveUntil(
                                                //       context,
                                                //       '/login',
                                                //       (route) => false);
                                                // } catch (e) {
                                                //   showSnackBar(
                                                //       context, e.toString());
                                                // }

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
              );
            }
          },
        ));
  }

Future<dynamic> buildShowDialog(BuildContext context, String action) {
  TextEditingController _controller = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Change the $action'),
            content: TextField(
              controller: _controller,
              decoration: InputDecoration(
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
                  onPressed: () async {
                    if (_controller.text.isNotEmpty) {
                      // change the $action
                      try {
                        bool isUpdated = await ProfileActions(
                                context: context)
                            .updateUserData(action, _controller.text);
                        if (isUpdated) {
                          Navigator.pop(context);
                          setState(() {});
                        }
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }
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
