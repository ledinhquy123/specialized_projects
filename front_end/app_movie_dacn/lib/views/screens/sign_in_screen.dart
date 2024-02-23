import 'dart:convert';

import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/services/users_api.dart';
import 'package:app_movie/utils/button_back.dart';
import 'package:app_movie/utils/show_snackbar.dart';
import 'package:app_movie/views/screens/home_screen.dart';
import 'package:app_movie/views/screens/sign_up_screen.dart';
import 'package:app_movie/views/screens/verify_email_screen.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:app_movie/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  static dynamic user;

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passObscure = true;
  bool checked = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            // width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
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
                showButtonBack(context, primaryMain2, primaryMain1, Icons.arrow_back, 64, 0),
                Form(
                  key: key,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 10
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/logo.png'),
                        const SizedBox(height: 16),
                              
                        Text(
                          'Đăng Nhập',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(height: 32),
                              
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
                              
                          prefixIcon: const Icon(
                            IconlyLight.message,
                            color: Colors.white,
                          ),
                              
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                  
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
                  
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Email không được để trống';
                            }
                            return null;
                          },
                  
                          controller: emailController,
                        ),
                        const SizedBox(height: 16),
                              
                        CustomTextFormField(
                          hintText: 'Nhập mật khẩu',
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
                              
                          prefixIcon: const Icon(
                            IconlyLight.lock,
                            color: Colors.white,
                          ),
                              
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passObscure = !passObscure;
                              });
                            }, 
                            icon: !passObscure ? const Icon(
                                IconlyLight.show,
                              color: Colors.white,
                            ) : const Icon(
                              IconlyLight.hide,
                              color: Colors.white,
                            )
                          ),
                              
                          obscureText: passObscure,
                          style: const TextStyle(color: Colors.white),
                  
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
                  
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Mật khẩu không được để trống';
                            }
                            return null;
                          },
                  
                          controller: passwordController,
                        ),
                        const SizedBox(height: 16),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  checked = !checked;
                                });
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: outline
                                  )
                                ),
                                child: Icon(
                                  checked ? Icons.check : null,
                                  color: Colors.white,
                                  size: 16,
                                ) ,
                              ),
                            ),
                            const SizedBox(width: 8),
                              
                            Text(
                              'Nhớ mật khẩu',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: outline
                              ),
                            ),
                            const SizedBox(width: 32),
                              
                              
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => const VerifyEmailScreen())
                                );
                              },
                              child: Text(
                                'Quên mật khẩu?',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                              
                        CustomButton(
                          text: 'Đăng Nhập',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                          ),
                          onTap: () async {
                            if (key.currentState!.validate()) {
                              showDialog(context: context, builder: (context) => const Center(
                                child: CircularProgressIndicator(
                                  color: primaryMain1,
                                ),
                              ));

                              bool check = await logInUser();

                              if(check) {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // ignore: use_build_context_synchronously
                                showSnackbar(context, 'Đăng nhập thành công', Colors.green);
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => const HomeScreen())
                                );
                              }else {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                passwordController.text = '';
                              }
                            }
                          }
                        ),
                        const SizedBox(height: 16),
                              
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                decoration: const BoxDecoration(
                                  color: outline
                                ),
                              )
                            ),
                              
                            Expanded(
                              child: Text(
                                'Hoặc tiếp tục với',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white
                                ),
                              )
                            ),
                              
                            Expanded(
                              child: Container(
                                height: 1,
                                decoration: const BoxDecoration(
                                  color: outline
                                ),
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                              
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                signInWithGoogle();
                                // sendGoogleSignInDataToApi('Lê Đình Quý');
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width/5,
                                height: MediaQuery.of(context).size.height/20,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(14)
                                  ),
                                  border: Border.all(
                                    width: 1,
                                    color: outline
                                  )
                                ),
                                child: Image.asset('assets/images/icon_google.png')
                              ),
                            ),
                            const SizedBox(width: 32),
                              
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width/5,
                                height: MediaQuery.of(context).size.height/20,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(14)
                                  ),
                                  border: Border.all(
                                    width: 1,
                                    color: outline
                                  )
                                ),
                                child: Image.asset('assets/images/icon_facebook.png')
                              ),
                            ),
                            const SizedBox(width: 32),
                              
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width/5,
                                height: MediaQuery.of(context).size.height/20,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(14)
                                  ),
                                  border: Border.all(
                                    width: 1,
                                    color: outline
                                  )
                                ),
                                child: Image.asset('assets/images/icon_apple.png')
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                              
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Bạn chưa có tài khoản?',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: outline
                              ),
                            ),
                            const SizedBox(width: 8),
                              
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()
                                  )
                                );
                              },
                              child: Text(
                                'Đăng kí ngay',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      await _googleSignIn.signIn();
      final GoogleSignInAccount? googleUser = _googleSignIn.currentUser;
      if (googleUser == null) {
        print('Đăng nhập không thành công');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

       // Gửi thông tin đăng nhập lên Laravel API
      if(googleUser.toString() != '' && googleAuth.accessToken != null) {
        String photoUrl = 'https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg';
        if(googleUser.photoUrl != null) {
          photoUrl = googleUser.photoUrl!;
        } 
        await sendGoogleSignInDataToApi(
          googleAuth.accessToken!,
          googleUser.id,
          googleUser.displayName!,
          googleUser.email,
          photoUrl
        );
      } else {
        print('Không thành công');
        return;
      }
    } catch (error) {
      print('Sao lại lỗi :))): $error');
    }
  }

  Future<void> sendGoogleSignInDataToApi(
    String accessToken, 
    String id,
    String name,
    String email, 
    String avatar
  ) async {
    final body = {
      'access_token': accessToken,
      'provider_id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
    final response = await UserApi.sendGoogleSignInDataToApi(body);

    if (response.statusCode == 200) {
      // Xử lý phản hồi từ Laravel API (nếu cần)
      // print(jsonDecode(response.body));
      final json = jsonDecode(response.body);
      if(json['user'] != null) {
        SignInScreen.user = json['user'];
        // ignore: use_build_context_synchronously
        showSnackbar(context, 'Đăng nhập thành công', Colors.green);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const HomeScreen())
        );
      }else {
        // ignore: use_build_context_synchronously
        showSnackbar(context, 'Đăng nhập thất bại', Colors.red);
      }
    } else {
      print('Failed to send Google Sign-In data. Error code: ${response.statusCode}');
    }
  }


  Future<bool> logInUser() async {
    final body = {
      'email': emailController.text,
      'password': passwordController.text
    };

    final response = await UserApi.signInUser(body);

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if(json['status'] != ''){
        if(json['status'] == 1) {
          SignInScreen.user = json['user'];

          return true;
        }else {
          // ignore: use_build_context_synchronously
          showSnackbar(context, 'Mật khẩu chưa chính xác', Colors.red);
          return false;
        }
      }else {
        // ignore: use_build_context_synchronously
        showSnackbar(context, 'Email hoặc mật khẩu không hợp lệ', Colors.red);
        return false;
      }
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}