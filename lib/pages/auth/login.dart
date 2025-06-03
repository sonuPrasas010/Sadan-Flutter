import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/components/forms/buttond.dart';
import 'package:sadan/components/forms/custom_input.dart';
import 'package:sadan/controllers/login_controller.dart';
import 'package:sadan/main.dart';
import 'package:sadan/pages/auth/register.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        key: loginController.formKey,
        child: GetBuilder<LoginController>(
            init: loginController,
            builder: (controller) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          'images/download.jpg',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              CustomFilledTextFormField(
                                name: 'Email',
                                validator: loginController.emailValidator,
                                controller: loginController.emailController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomFilledTextFormField(
                                name: 'Password',
                                validator: loginController.passWordValidator,
                                controller: loginController.passwordController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(child: Container()),
                                  Text(
                                    "Forget your Password?",
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Button(
                                    text: "Login",
                                    press: () {
                                      controller.login();
                                    }),
                              ),
                              SizedBox(height: 15),
                              Center(
                                  child: RichText(
                                      text: TextSpan(
                                          text: "Don't have account?  ",
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 20),
                                          children: [
                                    TextSpan(
                                        text: "Create",
                                        style: TextStyle(fontSize: 20),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.offAll(() => RegisterScreen());
                                          })
                                  ]))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (controller.isLoggingIn)
                    Container(
                      color: Colors.black54,
                      width: Get.width,
                      height: Get.height,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              );
            }),
      ),
    );
  }
}
