import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isDataProcessing.value == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.lstTask.length,
              itemBuilder: (context, indx) {
                print({"end ${controller.lstTask.length - 1}"});
                if (indx == controller.lstTask.length - 1 &&
                    controller.isMoreDataAvailable.value == true) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListTile(
                  title: Text(controller.lstTask[indx]["name"],
                  ),
                  subtitle: Text(controller.lstTask[indx]["full_name"]),
                );
              });
        }
      }),
    );
  }
}
