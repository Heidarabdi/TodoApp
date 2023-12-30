import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/service/user_auth.dart';

class LoginOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BuildButton(
          iconImage: Image(
            height: 20,
            width: 20,
            image: AssetImage('assets/images/facebook.png'),
          ),
          textButton: 'Facebook',
        ),
        GestureDetector(
          onTap: () async{
            try{
              var result = await FireAuth.signInWithGoogle(context: context);
              if(result != null){
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              }

            }catch(e){
              showSnackBar(context, e.toString());
            }
          },
          child: BuildButton(
            iconImage: Image(
              height: 20,
              width: 20,
              image: AssetImage('assets/images/google.png'),
            ),
            textButton: 'Google',
          ),
        ),
      ],
    );
  }
}

class BuildButton extends StatelessWidget {
  final Image iconImage;
  final String textButton;
  BuildButton({required this.iconImage, required this.textButton});
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.06,
      width: mediaQuery.width * 0.36,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconImage,
          SizedBox(
            width: 5,
          ),
          Text(textButton),
        ],
      ),
    );
  }
}
