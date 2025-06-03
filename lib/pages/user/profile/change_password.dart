import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sadan/components/forms/custom_input.dart';
import 'package:sadan/controllers/user_controller/change_password_controller.dart';

class ChangePassword extends StatelessWidget {
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: GetBuilder<ChangePasswordController>(
          init: changePasswordController,
          builder: (controller) {
            return Form(
              key: changePasswordController.formKey,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset('images/download.jpg'),
                      SizedBox(height: 30),
                      CustomFilledTextFormField(
                        name: "Old Password",
                        controller: changePasswordController.oldPassword,
                        validator: changePasswordController.oldPassordValidator,
                      ),
                      SizedBox(height: 30),
                      CustomFilledTextFormField(
                        name: "New Password",
                        controller: changePasswordController.passwordController,
                        validator: changePasswordController.passWordValidator,
                      ),
                      SizedBox(height: 30),
                      CustomFilledTextFormField(
                        name: "Confirm Password",
                        controller:
                            changePasswordController.confirmPasswordController,
                        validator:
                            changePasswordController.confirmPasswordValidator,
                      ),
                      SizedBox(height: 30),
                      Divider(),
                      SizedBox(height: 30),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.09,
                        decoration: BoxDecoration(
                            // color: Colors.amber,
                            // borderRadius: BorderRadius.circular(50),
                            ),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            changePasswordController.changePassword();
                          },
                          icon: Icon(Icons.loop),
                          label: Text('Change Password'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
