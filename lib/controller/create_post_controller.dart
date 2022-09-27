import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../util/constant.dart';

class CreatePostController extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  RxBool isSubmit= false.obs;

  RxString newId= "".obs;
  RxString newUserId= "".obs;
  RxString newTitle= "".obs;
  RxString newBody= "".obs;

  Future<void> createPosts(String title, String bodyText) async {
    try {
      EasyLoading.show(status: "Please wait...");
      var body= {
        "userId": "1",
        "title": title,
        "body": bodyText
      };
      log("check_body: $body");
      var response = await http.post(Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        body: body,
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        EasyLoading.dismiss();
        var decode= jsonDecode(response.body);
        log("check_create_response: $decode");
        newId.value= decode["id"].toString();
        newUserId.value= decode["userId"].toString();
        newTitle.value= decode["title"].toString();
        newBody.value= decode["body"].toString();
        showToast("Created successfully");
      } else {
        EasyLoading.dismiss();
        showToast("Internal error occur, Please try again");
      }
    } on SocketException {
      EasyLoading.dismiss();
      throw showToast("Connection error, Please try again");
    } on FormatException {
      EasyLoading.dismiss();
      throw showToast("Bad request, Please try again");
    } on TimeoutException {
      EasyLoading.dismiss();
      throw showToast("Timeout, Please try again");
    } catch (e) {
      EasyLoading.dismiss();
      log("check_error: ${e.toString()}");
      throw showToast("Somethings want wrong, Please try again");
    }
  }

}