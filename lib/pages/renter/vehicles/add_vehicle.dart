import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sadan/components/forms/custom_input.dart';
import 'package:sadan/components/forms/text_divider.dart';
import 'package:sadan/components/sizedBoxes/box.dart';
import 'package:sadan/controllers/renter_controler/add_vechicle_controller.dart';


class AddVehicleScreen extends StatelessWidget {
  final AddVehicleController addVehicleController =
      Get.put(AddVehicleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Vehicle"),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          addVehicleController.addVehicle();
        },
        child: Text("Add Vehicle"),
      ),
      body: GetBuilder<AddVehicleController>(
          init: addVehicleController,
          builder: (controller) {
            if (controller.isLoadingCategories) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (controller.categories.isEmpty) {
              return Center(
                child: ElevatedButton(
                  child: Text("Refresh"),
                  onPressed: () {
                    controller.GetCategories();
                  },
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: controller.formKey,
                child: ListView(
                  children: [
                    SizedBoxH15,
                    CustomFormField(
                      name: "Brand",
                      controller: controller.brandController,
                      validator: controller.validateEmptyField,
                    ),
                    SizedBoxH15,
                    CustomFormField(
                      name: "Model",
                      controller: controller.modelController,
                      inputType: TextInputType.text,
                      validator: controller.validateEmptyField,
                    ),
                    SizedBoxH15,
                    CustomFormField(
                      name: "Color",
                      controller: controller.colorController,
                      validator: controller.validateEmptyField,
                      inputType: TextInputType.text,
                    ),
                    SizedBoxH15,
                    CustomFormField(
                      name: "Manufacture Year",
                      controller: controller.manufactureyear,
                      inputType: TextInputType.number,
                      validator: controller.validateEmptyField,
                    ),
                    SizedBoxH15,
                    CustomFormField(
                      name: "Rate Per Hours",
                      controller: controller.ratePerHourController,
                      validator: controller.validateEmptyField,
                      inputType: TextInputType.number,
                    ),
                    SizedBoxH15,
                    CustomFormField(
                      name: "Rate Per Day",
                      controller: controller.ratePerDayController,
                      validator: controller.validateEmptyField,
                      inputType: TextInputType.number,
                    ),
                    SizedBoxH15,
                    CustomFormField(
                      name: "Last Service Date (YY-MM-DD)",
                      controller: controller.lastServiceDateController,
                      validator: controller.validateEmptyField,
                      onTap: () => controller.selectDate(context),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                          )),
                      child: DropdownButton(
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        hint: Text(controller.selectedCategoryName ?? ""),

                        isExpanded: true,
                        alignment: Alignment.center,
                        // Initial Value
                        value: controller.selectedCategoryName,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: controller.categoriesName.map((items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (_) {
                          if (_ == null) return;
                          for (var data in controller.categories) {
                            if (data['name'] == _) {
                              controller.SelectedCategoryid = data['id'];
                              controller.selectedCategoryName = data['name'];
                              controller.update();
                            }
                          }
                        },
                      ),
                    ),
                    SizedBoxH15,
                    TextDivider(text: "Pictures"),
                    CustomFilePicker(
                      () async {
                        controller.vehicleImage = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        controller.update();
                      },
                      labelText: "Vehicle Image",
                      fileName: controller.vehicleImage?.name,
                    ),
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
