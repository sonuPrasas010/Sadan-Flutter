import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sadan/components/forms/custom_input.dart';
import 'package:sadan/components/forms/text_divider.dart';
import 'package:sadan/components/sizedBoxes/box.dart';
import 'package:sadan/configs/strings.dart';
import 'package:sadan/controllers/user_controller/user_kyc_controller.dart';

class UserKycScreen extends StatelessWidget {
  final UserKYCController _kycController = Get.put(UserKYCController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Kyc Verify"),
      ),
      bottomNavigationBar: GetBuilder<UserKYCController>(
          init: _kycController,
          builder: (context) {
            return ElevatedButton(
              onPressed: _kycController.isLoading == true
                  ? null
                  : () {
                      _kycController.submitKYC();
                    },
              child: Text(_kycController.isLoading == true
                  ? "Uploading"
                  : "Submit Kyc"),
            );
          }),
      body: GetBuilder<UserKYCController>(
          init: _kycController,
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: controller.formKey,
                child: ListView(
                  children: [
                    SizedBoxH15,
                    CustomFormField(
                      name: "Name",
                      controller: controller.nameController,
                      validator: controller.validateEmptyField,
                    ),
                    SizedBoxH15,
                    CustomFormField(
                      name: "Phone Number",
                      controller: controller.phoneNumberController,
                      inputType: TextInputType.phone,
                      validator: controller.validateEmptyField,
                    ),
                    SizedBoxH15,
                    CustomFormField(
                      name: "DOB (YY-MM-DD)",
                      onTap: () => controller.selectDate(context),
                      controller: controller.dOBController,
                      validator: controller.validateEmptyField,
                      inputType: TextInputType.number,
                    ),
                    SizedBoxH15,
                    CustomFormField(
                      name: "Address",
                      controller: controller.addressController,
                      inputType: TextInputType.multiline,
                      validator: controller.validateEmptyField,
                    ),
                    // SizedBoxH15,
                    // CustomDropDown(
                    //   docType,
                    //   value: controller.selectedDocType,
                    //   onChanged: controller.onDocChanged,
                    // ),
                    SizedBoxH15,
                    CustomDropDown(
                      genders,
                      value: controller.selectedGender,
                      onChanged: controller.onGanderChanged,
                    ),
                    TextDivider(text: "Documents"),
                    SizedBoxH15,
                    CustomFormField(
                      name: "Identification Number",
                      controller: controller.identificationNumberController,
                      validator: controller.validateEmptyField,
                    ),
                    SizedBoxH15,
                    // CustomFormField(
                    //   name: "License Number",
                    //   controller: controller.liscnceNumberController,
                    //   validator: controller.validateEmptyField,
                    // ),
                    SizedBoxH15,
                    TextDivider(text: "Pictures"),
                    SizedBoxH15,
                    CustomFilePicker(
                      controller.pickCitizenshipFront,
                      fileName: "Citizenship front and back",
                      labelText: "Citizenship Front",
                    ),

                    // SizedBoxH15,
                    // CustomFilePicker(
                    //   controller.pickCitizenshipBack,
                    //   fileName: controller.citizenshipBack?.name,
                    //   labelText: "Citizenship Back",
                    // ),
                    // SizedBoxH15,
                    // CustomFilePicker(
                    //   controller.pickLicense,
                    //   labelText: "License",
                    //   fileName: controller.liscensePhoto?.name,
                    // ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class CustomFilePicker extends StatelessWidget {
  final Function onClicked;
  final String? fileName;
  final String labelText;
  CustomFilePicker(this.onClicked, {this.fileName, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          onTap: () => onClicked(),
          readOnly: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.upload,
            ),
            hintText: fileName ?? "Upload",
            label: Text(labelText),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropDown extends StatelessWidget {
  final List items;
  final value;
  final Function onChanged;
  CustomDropDown(this.items, {this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
          )),
      child: DropdownButton(
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        hint: Text("Gender"),

        isExpanded: true,
        alignment: Alignment.center,
        // Initial Value
        value: value,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: items.map((items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (_) {
          onChanged(_);
        },
      ),
    );
  }
}
