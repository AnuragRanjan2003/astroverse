import 'package:astroverse/components/new_posts_page.dart';
import 'package:astroverse/controllers/main_controller.dart';
import 'package:astroverse/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';

class DiscoverScreenPortrait extends StatelessWidget {
  final BoxConstraints cons;
  final Color color;

  const DiscoverScreenPortrait(
      {super.key, required this.cons, required this.color});

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find();
    final MainController main = Get.find();
    final ht = cons.maxHeight;
    final wd = cons.maxWidth;
    int index = 4;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: color,
        floatingActionButton: Obx(() {
          if (auth.user.value?.astro == true) {
            return FloatingActionButton(
              onPressed: () {
                Get.toNamed(Routes.createPostScreen);
              },
              backgroundColor: Colors.lightBlue.shade300,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: const FaIcon(
                FontAwesomeIcons.penNib,
                color: Colors.white,
                size: 17,
              ),
            );
          }
          return const SizedBox(
            height: 0,
          );
        }),
        body: SizedBox(
            width: wd,
            child: Column(
              children: [
                const TabBar(
                  indicatorColor: Colors.lightBlue,
                  labelColor: Colors.lightBlue,
                  tabs: [
                    Tab(
                      text: "new",
                    ),
                    Tab(
                      text: "following",
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(children: [
                    Center(
                      child: NewPostsPage(
                        cons: cons,
                      ),
                    ),
                    const Center(
                      child: Text("following"),
                    ),
                  ]),
                ),
              ],
            )),
      ),
    );
  }
}
