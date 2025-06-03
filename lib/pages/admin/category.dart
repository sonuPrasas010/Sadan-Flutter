import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadan/configs/api.dart';
import 'package:sadan/configs/strings.dart';
import 'package:sadan/controllers/admin_controller/category_controller.dart';
import 'package:sadan/pages/admin/add_category.dart';
import 'package:sadan/pages/user/vehicle/get_vehicles.dart';

class Categories extends StatelessWidget {
  CategoryCOntroller categoryCOntroller = Get.put(CategoryCOntroller());
  Categories(this.role);
  String role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        actions: [
          if (role == roles[2])
            IconButton(
                onPressed: () {
                  Get.to(() => AddCategory());
                },
                icon: Icon(Icons.add))
        ],
      ),
      body: GetBuilder(
          init: categoryCOntroller,
          builder: (controller) {
            if (controller.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (controller.categories.isEmpty) {
              return ElevatedButton(
                  onPressed: () {
                    controller.GetCategories();
                  },
                  child: Text("Reload"));
            }
            return RefreshIndicator(
              onRefresh: () async {
                categoryCOntroller.GetCategories();
              },
              child: ListView.separated(
                  itemCount: controller.categories.length,
                  separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (role == roles[0]) {
                          Get.to(() => UserGetVehicles(
                              categoryCOntroller.categories[index]['id']));
                        }
                      },
                      child: Container(
                        height: 150,
                        decoration:
                            BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Builder(builder: (context) {
                              if (controller.categories[index]['image'] != null)
                                return Image.network(
                                  "$API_URL/" +
                                      controller.categories[index]['image']
                                          .toString()
                                          .replaceAll(
                                            "uploads",
                                            "",
                                          ),
                                  height: 120,
                                  width: 60,
                                  fit: BoxFit.contain,
                                );
                              return Image.asset(
                                "images/cars.png",
                                height: 120,
                                width: 60,
                                fit: BoxFit.contain,
                              );
                            }),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              // flex: 3,
                              child: Text(
                                categoryCOntroller.categories[index]['name'],
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                            Spacer(),
                            if (role == roles[2])
                              IconButton(
                                  onPressed: () {
                                    controller.deleteCategory(
                                        id: categoryCOntroller.categories[index]
                                            ['id'],
                                        index: index);
                                  },
                                  icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }),
    );
  }
}
