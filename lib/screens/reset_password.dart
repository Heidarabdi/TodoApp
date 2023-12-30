import 'dart:async';

import 'package:flutter/material.dart';
import '../constant.dart';
import '../service/user_auth.dart';
import '../theme.dart';
import '../widgets/primary_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final ValueNotifier<bool> _buttonEnabled = ValueNotifier<bool>(true);
  TextEditingController emailcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 250,
              ),
              Text(
                'Reset Password',
                style: titleText,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Please enter your email address',
                style: subTitle.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: emailcontroller,
                  decoration: const InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: kTextFieldColor),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor))),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _buttonEnabled,
                builder: (context, value, child) {
                  return GestureDetector(
                    onTap : value ?
                        () async {
                      if(emailcontroller.text.isEmpty) {
                        showSnackBar(context, 'Please enter email');
                        return;
                      }
                      _buttonEnabled.value = false;
                      try {
                        await FireAuth.resetPassword(context:context,
                                email : emailcontroller.text);
                        Timer(const Duration(seconds: 2), () {
                          Navigator.pop(context);
                        });
                      } catch (error) {
                        showSnackBar(context, error.toString());
                      }
                      _buttonEnabled.value = true;
                    } : null,

                    child: const PrimaryButton(buttonText: 'Reset Password'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}