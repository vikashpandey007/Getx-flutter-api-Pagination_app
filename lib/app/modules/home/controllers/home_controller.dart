import 'package:api_pagination/app/modules/home/providers/userdata_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var page = 1;
  var per_page = 15;
  var isDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;
  var lstTask = List<dynamic>.empty(growable: true).obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    getdata(page, per_page);
    paginateTask();
    super.onInit();
  }

  void getdata(page, per_page) {
    try {
      isMoreDataAvailable(false);
      isDataProcessing(true);
      UserdataProvider().getUserdata(page, per_page).then((resp) {
        isDataProcessing(false);
        lstTask.addAll(resp);
      }, onError: (err) {
        isDataProcessing(false);
        Get.snackbar("Error", err.toString(),
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      });
    } catch (exception) {
      isDataProcessing(false);
      Get.snackbar("Exception", exception.toString(),
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void paginateTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("reached end");
        page++;
        getMoredata(page, per_page);
      }
    });
  }

  void getMoredata(page, per_page) {
    try {
      UserdataProvider().getUserdata(page, per_page).then((resp) {
        if (resp.length > 0) {
          isMoreDataAvailable(true);
        } else {
          isMoreDataAvailable(false);
          Get.snackbar("Message", "No more items",
              backgroundColor: Colors.lightBlue,
              snackPosition: SnackPosition.BOTTOM);
        }
        lstTask.addAll(resp);
      }, onError: (err) {
        isMoreDataAvailable(false);
        Get.snackbar("Error", err.toString(),
            backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      });
    } catch (exception) {
      isMoreDataAvailable(false);
      Get.snackbar("Exception", exception.toString(),
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {}
}
