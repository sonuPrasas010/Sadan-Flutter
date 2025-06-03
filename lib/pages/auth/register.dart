import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/components/forms/buttond.dart';
import 'package:sadan/components/forms/custom_input.dart';
import 'package:sadan/configs/strings.dart';
import 'package:sadan/pages/auth/login.dart';

import '../../controllers/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController _registerController = Get.put(RegisterController());
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: _registerController.formKey,
        child: GetBuilder<RegisterController>(
            init: _registerController,
            builder: (controller) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset(
                            "images/download.jpg",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomFilledTextFormField(
                            name: 'Name',
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                            validator: _registerController.nameValidator,
                            controller: _registerController.nameController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomFilledTextFormField(
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            name: 'Email',
                            validator: _registerController.emailValidator,
                            controller: _registerController.emailController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomFilledTextFormField(
                            prefixIcon: Icon(Icons.remove_red_eye_rounded),
                            name: 'Password',
                            validator: _registerController.passWordValidator,
                            controller: _registerController.passwordController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomFilledTextFormField(
                            prefixIcon: Icon(Icons.lock),
                            name: "Confirm Password",
                            validator:
                                _registerController.confirmPasswordValidator,
                            controller:
                                _registerController.confirmPasswordController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Register as: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: DropdownButton(
                                  // Initial Value
                                  value: controller.role,

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: roles.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: _registerController.changeRole,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Button(
                                text: "Sign Up",
                                press: () {
                                  controller.register();
                                }),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: RichText(
                                text: TextSpan(
                                    text: "Already have an account?  ",
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 20),
                                    children: [
                                  TextSpan(
                                      text: "Login",
                                      style: TextStyle(fontSize: 20),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.offAll(() => LoginScreen());
                                        }),
                                ])),
                          ),
                          ElevatedButton(
                              onPressed: _registerController.register,
                              child: Text("Register")),
                        ],
                      ),
                    ),
                  ),
                  if (controller.isRegistering)
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
