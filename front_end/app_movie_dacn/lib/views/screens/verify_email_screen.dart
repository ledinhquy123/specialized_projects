import 'dart:math';

import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/utils/button_back.dart';
import 'package:app_movie/views/screens/forgot_password_screen.dart';
import 'package:app_movie/views/widgets/custom_button.dart';

import 'package:app_movie/views/widgets/custom_text_form_field.dart';
import 'package:email_sender/email_sender.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool checkEmail = false;
  String inpEmail = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [ primaryMain1, primaryMain2 ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
              ),
              color: Colors.grey.withOpacity(.7),
            ),
            child: Stack(
              children: [
                showButtonBack(context),
                Form(
                  key: key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo.png'),
                      const SizedBox(height: 32),      
                          
                      Text(
                        'Nhập email',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.white
                        ),
                      ),
                      Text(
                        "Nhập email của bạn để thay đổi mật khẩu",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: outline
                        ),
                      ),
                      const SizedBox(height: 16),      
                
                      CustomTextFormField(
                        hintText: 'Nhập email',
                        hintStyle: const TextStyle(
                          color: outline,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30)
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: outline
                          )
                        ),
                            
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30)
                          ),
                          borderSide: BorderSide(
                            width: 2,
                            color: outline,
                          )
                        ),

                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30)
                          ),
                          borderSide: BorderSide(
                            width: 2,
                            color: primaryMain1,
                          )
                        ),

                        errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: primaryMain1,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700
                        ),

                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30)
                          ),
                          borderSide: BorderSide(
                            width: 2,
                            color: primaryMain1,
                          )
                        ),
                            
                        prefixIcon: const Icon(
                          IconlyLight.message,
                          color: Colors.white,
                        ),
                            
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                            checkEmail = RegExp(emailRegex).hasMatch(value);
                            inpEmail = value;
                          });
                        },
                        validator: (value) {
                          if(value!.isEmpty) {
                            return 'Email không được trống';
                          }

                          if(!checkEmail) {
                            return 'Email không hợp lệ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),      
                
                      CustomButton(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.height / 20,
                        text: 'Xác Nhận',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700
                        ),
                        onTap: () {
                          if(key.currentState!.validate()) {
                            Random random = Random();
                            // Tạo số ngẫu nhiên từ 10^(3) đến 10^4 - 1
                            int randomNumber = random.nextInt((pow(10, 4) - pow(10, 3)).toInt()) + pow(10, 3).toInt();

                            sendEmail(inpEmail, randomNumber);
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => ForgotPassWordScreen(
                                  inpEmail: inpEmail, 
                                  code: randomNumber.toString()
                                )
                              )
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
Future<void> sendEmail(String email, int randomNumber) async {
  try {
    EmailSender emailSender = EmailSender();
    await emailSender.sendOtp(email, randomNumber);
    print('email was sent');
  } catch (error) {
    print('Error: $error');
  }
}