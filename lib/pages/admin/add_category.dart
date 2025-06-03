import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sadan/components/forms/custom_input.dart';
import 'package:sadan/components/sizedBoxes/box.dart';

import 'package:sadan/controllers/admin_controller/category_controller.dart';

class AddCategory extends StatelessWidget {
  CategoryCOntroller categoryCOntroller = Get.put(CategoryCOntroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: GetBuilder<CategoryCOntroller>(builder: (controller) {
        return Form(
            child: ListView(
          children: [
            CustomFormField(
              name: "Category Name",
              controller: controller.nameController,
            ),
            SizedBoxH15,
            CustomFormField(
              name: controller.image?.name ?? "Image",
              controller: TextEditingController(),
              onTap: () {
                controller.pickImage();
              },
            ),
            SizedBoxH15,
            ElevatedButton(
                onPressed: controller.isAdding
                    ? null
                    : () {
                        controller.AddCategory();
                      },
                child: controller.isAdding
                    ? Text("Is Loading")
                    : Text("Add Category"))
          ],
        ));
      }),
    );
  }
}
