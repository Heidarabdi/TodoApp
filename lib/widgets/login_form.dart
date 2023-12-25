import 'package:flutter/material.dart';

import '../constant.dart';
import '../screens/reset_password.dart';
import '../theme.dart';
import 'primary_button.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildInputForm('Email', false),
          buildInputForm('Password', true),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResetPasswordScreen()));
            },
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Forgot password?',
                style: TextStyle(
                  color: kZambeziColor,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  decorationThickness: 1,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: (){
              if (_formKey.currentState!.validate()) {
                showSnackBar(context, 'Log In Success');
              }
            },
            child: const PrimaryButton(
              buttonText: 'Log In',
            ),
          ),
        ],
      ),
    );
  }

  Padding buildInputForm(String label, bool pass) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: pass ? passwordController : emailController,
        obscureText: pass ? _isObscure : false,

        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $label';
          }
          return null;


        },

        decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: kTextFieldColor,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
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
                          ),
                  )
                : null),
      ),

    );
  }
}
