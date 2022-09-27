import 'package:assignment/util/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/create_post_controller.dart';
import '../util/constant.dart';

class CreatePost extends StatelessWidget {

  var appController= Get.put(CreatePostController());
  TextEditingController titleController= TextEditingController();
  TextEditingController bodyController= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Obx(() => Visibility(
              visible: appController.isSubmit.isTrue ? true : false,
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(.2),
                ),
                child: Column(
                  children: [
                    SingleWidget.listItemText("User ID :", appController.newUserId.toString()),
                    SingleWidget.listItemText("Id :", appController.newId.toString()),
                    SingleWidget.listItemText("Title :", appController.newTitle.toString()),
                    SingleWidget.listItemText("Body :", appController.newBody.toString()),
                  ],
                ),
              ),
            ),),

            Obx(() => Visibility(
              visible: appController.isSubmit.isTrue ? false : true,
              child: Container(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        "Title",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(.6),
                        ),
                      ),
                    ),

                    Container(
                      height: 48,
                      padding: const EdgeInsets.only(left: 5),
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.amber),
                      ),
                      child: TextField(
                        controller: titleController,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.white,
                          hintText: "Update title here",
                          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        "Body",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(.6),
                        ),
                      ),
                    ),

                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.amber),
                      ),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: bodyController,
                        cursorColor: Colors.blue,
                        maxLines: 150 ~/ 20,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.white,
                          hintText: "Update title here",
                          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),

                    InkWell(
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: const Text(
                          "Submit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        if(titleController.text.toString().isEmpty){
                          showToast("Please enter title");
                        } else if(bodyController.text.toString().isEmpty){
                          showToast("Please enter body");
                        } else {
                          appController.isSubmit.value= true;
                          appController.createPosts(titleController.text.toString(), bodyController.text.toString());
                        }
                      },
                    ),

                  ],
                ),
              ),
            ),),

          ],
        ),
      ),
    );
  }

}
