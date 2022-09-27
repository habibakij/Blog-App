import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../util/constant.dart';

class MainController extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  RxList favouriteList= [].obs;
  late RxList lst;

  /// read all posts
  RxList allPost= [].obs;
  RxList idList= [].obs;
  RxList usrIdList= [].obs;
  RxList titleList= [].obs;
  RxList bodyList= [].obs;
  Future<void> getAllPosts() async {
    try {
      EasyLoading.show(status: "Please wait...");
      var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if(response.statusCode == 200 || response.statusCode == 201){
        EasyLoading.dismiss();
        var decode= jsonDecode(response.body);
        allPost.value= decode;
        lst= RxList.filled(allPost.length, null, growable: false);
        log("response: $allPost, length: $lst");
        for (var element in allPost) {
          Map map= element;
          idList.add(map["id"]);
          usrIdList.add(map["userId"]);
          titleList.add(map["title"].toString());
          bodyList.add(map["body"].toString());
        }
        log("all_post_response: $idList, $usrIdList, $titleList, $bodyList ");
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
      throw showToast("Somethings want wrong, Please try again");
    }
  }

  /// delete single post
  Future<void> deletePost(String id) async{
    try {
      EasyLoading.show(status: "Please wait...");
      var response = await http.delete(Uri.parse("https://jsonplaceholder.typicode.com/posts/$id"));
      if(response.statusCode == 200 || response.statusCode == 201){
        EasyLoading.dismiss();
        showToast("Deleted successfully");
        getAllPosts();
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
      throw showToast("Somethings want wrong, Please try again");
    }
  }

}