import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../util/constant.dart';

class DetailsController extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  RxBool updateVisibility= false.obs;

  /// post details
  RxList postDetailsResponse= [].obs;
  RxString postId= "".obs;
  RxString postUsrId= "".obs;
  RxString postTitle= "".obs;
  RxString postBody= "".obs;
  Future<void> postDetails(String id) async {
    try {
      EasyLoading.show(status: "Please wait...");
      var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/$id"));
      if(response.statusCode == 200 || response.statusCode == 201){
        EasyLoading.dismiss();
        var decode= jsonDecode(response.body);
        postId.value= decode["id"].toString();
        postUsrId.value= decode["userId"].toString();
        postTitle.value= decode["title"].toString();
        postBody.value= decode["body"].toString();
        log("post_response: $postId, $postUsrId, $postTitle, $postBody");
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
      //throw Exception("something");
      EasyLoading.dismiss();
      log("check_error: ${e.toString()}");
      throw showToast("Somethings want wrong, Please try again");
    }
  }

  /// post update
  Future<void> updatePosts(String id, String userID, String title, String bodyText) async {
    try {
      EasyLoading.show(status: "Please wait...");
      var body= {
        "id": id,
        "userId": userID,
        "title": title,
        "body": bodyText
      };
      log("check_body: $body");
      var response = await http.put(Uri.parse("https://jsonplaceholder.typicode.com/posts/$id"),
        body: body,

      );
      if(response.statusCode == 200 || response.statusCode == 201){
        EasyLoading.dismiss();
        var decode= jsonDecode(response.body);
        postId.value= decode["id"].toString();
        postUsrId.value= decode["userId"].toString();
        postTitle.value= decode["title"].toString();
        postBody.value= decode["body"].toString();
        log("check_update_response: $decode");
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