import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/service/user_auth.dart';
import 'package:todo_app/widgets/primary_button.dart';

import '../theme.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isObscure = true;
  bool isLoading = false;

  // text controller
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // dispose text controller
  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }



  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildInputForm('FullName', false, fullNameController),
          const Gap(10),
          buildInputForm('Email', false , emailController),
          const Gap(10),
          buildInputForm('Phone', false , phoneController),
          const Gap(10),
          buildInputForm('Password', true , passwordController),
          const Gap(10),
          buildInputForm('Confirm Password', true , confirmPasswordController),
          const Gap(20),
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState!.validate()) {

                try {
                  setState(() {
                    isLoading = true;
                  });
                  var result = await FireAuth.registerUsingEmailPassword(
                      fullname: fullNameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      password: passwordController.text,
                      profileUrl: '',
                      context: context
                  );
                  if (result != null) {
                    textClear();
                    Navigator.pushNamed(context, '/login');
                  }




                } catch (e) {
                  showSnackBar(context, e.toString());
                }finally{
                  setState(() {
                    isLoading = false;
                  });
                }
              }
            },
              child: isLoading ? const Center(child: CircularProgressIndicator(
                color: kPrimaryColor,
                strokeWidth: 2,
              )) : const PrimaryButton(buttonText: 'Sign Up',)),
        ],
      ),
    );
  }

  Padding buildInputForm(String hint, bool pass , TextEditingController _controller) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller: _controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $hint';
            }
            // else if(hint == 'Email' && !value.contains('@') && !value.contains('.') && value.length < 6){
            //   return 'Please enter valid email';
            // }
            else if(hint == 'Phone' && value.length < 9 && value.contains(RegExp(r'[0-9]'))){
              return 'Please enter valid phone number';
            }
            // else if(hint == 'Password' && value.length < 6 && value.length > 30){
            //   return 'Password must be at least 6 characters';
            // }
            // else if(hint == 'Confirm Password' && value.length < 6 && value.length > 30){
            //   return 'Password must be at least 6 characters';
            // }
            else if(hint == 'FullName' && value.length < 3 && value.length > 30) {
              return 'Please enter valid name';
            }
            else if(hint == 'Confirm Password' && value != passwordController.text){
              return 'Password not match';
            }
            return null;
          },
          obscureText: pass ? _isObscure : false,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: kTextFieldColor),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? const Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ))
                : null,
          ),
        ));
  }

  void textClear() {
    fullNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
