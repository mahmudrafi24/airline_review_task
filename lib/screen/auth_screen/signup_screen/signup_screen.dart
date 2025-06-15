import 'package:airline_reveiw/utils/app_colors/app_colors.dart';
import 'package:airline_reveiw/widget/app_text/app_text.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppText(text: "Sign Up", fontSize: 30,fontWeight: FontWeight.w600, color: AppColors.buttonColor,),
      ),
    );
  }
}