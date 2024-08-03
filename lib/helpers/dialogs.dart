import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialogs{


  static success ({ required String msg }) {
    Get.snackbar('Success!', msg , colorText: Colors.black);

  }
    static error  ({ required String msg }) {
      Get.snackbar('Error!', msg , colorText: Colors.black,);

    }
      static info ({ required String msg }) {

        Get.snackbar('Info', msg , colorText: Colors.black);
      }

      static showProgress () {

        Get.dialog(Center(child: CircularProgressIndicator(strokeWidth: 4, color: Colors.teal,),));
      }
}