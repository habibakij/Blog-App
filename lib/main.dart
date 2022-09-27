import 'package:assignment/controller/main_controller.dart';
import 'package:assignment/screen/create_post.dart';
import 'package:assignment/screen/details_screen.dart';
import 'package:assignment/util/constant.dart';
import 'package:assignment/util/widget/widget.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var appController= Get.put(MainController());
  @override
  void initState() {
    super.initState();
    appController.getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
      ),
      body: DelayedDisplay(
        delay: const Duration(seconds: 1),
        slidingBeginOffset:const Offset(0.0, 0.10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 10),
                NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification? overscroll) {
                    overscroll!.disallowIndicator();
                    return true;
                  },
                  child: Obx(() => StaggeredGridView.countBuilder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 12,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: appController.allPost.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(.2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SingleWidget.listItemText("User ID :", appController.usrIdList[index].toString()),
                              SingleWidget.listItemText("Id :", appController.idList[index].toString()),
                              SingleWidget.listItemText("Title :", appController.titleList[index].toString()),
                              SingleWidget.listItemText("Body :", appController.bodyList[index].toString()),
                              const Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                      onTap: (){
                                        showToast("deleted");
                                        SingleWidget.deleteDialog(context, appController.idList[index].toString());
                                      },
                                    ),
                                  ),

                                  Row(
                                    children: [

                                      Obx(() => Visibility(
                                        visible: appController.lst[index] != "1" ? true : false,
                                        child: Container(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: InkWell(
                                            child: const Icon(
                                              Icons.favorite_border,
                                              size: 20,
                                              color: Colors.grey,
                                            ),
                                            onTap: (){
                                              appController.lst[index]= "1";
                                              showToast("Added favourite");
                                            },
                                          ),
                                        ),
                                      ),),

                                      Obx(() => Visibility(
                                        visible: appController.lst[index] == "1" ? true : false,
                                        child: Container(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: InkWell(
                                            child: const Icon(
                                              Icons.favorite,
                                              size: 20,
                                              color: Colors.red,
                                            ),
                                            onTap: (){
                                              appController.lst[index]= "0";
                                              showToast("Removed favourite");
                                            },
                                          ),
                                        ),
                                      ),),

                                    ],
                                  ),

                                ],
                              ),
                            ],
                          ),

                        ),
                        onTap: (){
                          Get.to(DetailsScreen(id: appController.idList[index].toString()));
                        },
                      );
                    },
                    staggeredTileBuilder: (int index) {
                      return const StaggeredTile.fit(12);
                    },
                  ),),
                )

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(CreatePost());
        },
        child: const Icon(
          Icons.add,
          size: 24,
        ),
      ),
    );
  }


}
