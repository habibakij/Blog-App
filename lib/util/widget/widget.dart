
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/main_controller.dart';

class SingleWidget{

  static final appController= Get.put(MainController());

  static Widget listItemText(String title, String text){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Container(
          width: 60,
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ),

        Container(
          padding: const EdgeInsets.only(top: 5),
          width: Get.width - 100,
          child: Text(
            text,
            style: const TextStyle(fontSize: 12),
            maxLines: 3,
          ),
        ),
      ],
    );
  }

  static Future<void> deleteDialog(BuildContext context, String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context1) {
        return DelayedDisplay(
          delay: const Duration(milliseconds: 100),
          slidingBeginOffset:const Offset(0.0, 0.10),
          child: CupertinoAlertDialog(
            title: const Text(
              "Delete",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            content: Container(
              height: 100,
              width: 150,
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Are you sure deleted this item ?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    height: 1,
                    margin: const EdgeInsets.only(top: 10),
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () async {
                          appController.deletePost(id);
                          Navigator.pop(context1);
                        },
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.grey,
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context1);
                        },
                        child: const Text(
                          "No",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}



