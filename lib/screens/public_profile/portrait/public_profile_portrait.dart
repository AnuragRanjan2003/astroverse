import 'package:astroverse/components/person_items.dart';
import 'package:astroverse/components/person_posts.dart';
import 'package:astroverse/controllers/public_profile_controller.dart';
import 'package:astroverse/models/extra_info.dart';
import 'package:astroverse/models/user.dart';
import 'package:astroverse/res/img/images.dart';
import 'package:astroverse/res/textStyles/text_styles.dart';
import 'package:astroverse/utils/num_parser.dart';
import 'package:astroverse/utils/zego_cloud_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class PublicProfilePortrait extends StatelessWidget {
  final BoxConstraints cons;
  static const _imageRadius = 60.00;

  const PublicProfilePortrait({super.key, required this.cons});

  @override
  Widget build(BuildContext context) {
    final User user = Get.arguments;
    final PublicProfileController public = Get.find();
    final zegoService = ZegoCloudServices();
    final ht = cons.maxHeight;
    public.getExtraInfo(user.uid);
    public.updateProfileViews(user.uid);


    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          surfaceTintColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 7, child: zegoService.callButton(user.uid, user.name)),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      // Add your button click logic here
                    },
                    child: Container(
                      width: 80, // Set the width of the button
                      height: 80, // Set the height of the button
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, // Makes the container circular
                        color: Colors
                            .lightBlue, // Set the background color of the button
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.messenger_outlined,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTopBanner(ht, user.image),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    user.name,
                    style: TextStylesLight().bodyBold,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(user.email),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    if (public.info.value == null) {
                      return _buildDataShimmerChips();
                    }
                    return _buildDataChips(
                        public.info.value!, user.profileViews,user.points);
                  }),
                  const SizedBox(
                    height: 25,
                  ),
                  Obx(() {
                    final info = public.info.value;
                    if (info == null) return _buildDatesColumnShimmer();
                    return _buildDatesColumn(info.joiningDate, info.lastActive);
                  }),
                ],
              ),
            ),
            const TabBar(
              tabs: [
                Tab(text: 'posts'),
                Tab(text: 'items'),
              ],
            ),
            const Expanded(
                child: TabBarView(
              children: [
                Center(child: PersonPosts()),
                Center(child: PersonItems()),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Container _buildDatesColumn(DateTime joiningDate, DateTime lastSeen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 0.5)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Joined on",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              ),
              Text(
                DateFormat('dd MMM, yyyy').format(joiningDate),
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Last active on",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              ),
              Text(
                DateFormat('dd MMM, yyyy').format(lastSeen),
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildDatesColumnShimmer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 0.5)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Joined on",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              ),
              Shimmer.fromColors(
                baseColor: const Color(0xffd3d3d3),
                highlightColor: const Color(0x0fe6e1e1),
                child: Container(
                  width: 80,
                  height: 20,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Last active on",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              ),
              Shimmer.fromColors(
                baseColor: const Color(0xffd3d3d3),
                highlightColor: const Color(0x0fe6e1e1),
                child: Container(
                  width: 80,
                  height: 20,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopBanner(double ht, String image) {
    return SizedBox(
      height: ht * 0.18 + _imageRadius,
      child: Stack(
        children: [
          Image(
            image: ProjectImages.background,
            width: double.infinity,
            fit: BoxFit.fitWidth,
            height: ht * 0.18,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: _imageRadius,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.all(Radius.circular(_imageRadius)),
                child: Image(
                  image: NetworkImage(image),
                  fit: BoxFit.fill,
                  height: 2 * (_imageRadius - 5),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDataChips(ExtraInfo info, int views,int points) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        _buildChip(Icons.shopping_bag, NumberParser().toSocialMediaString(info.servicesSold), Colors.green),
        _buildChip(Icons.data_exploration, NumberParser().toSocialMediaString(info.posts), Colors.blue),
        _buildChip(Icons.remove_red_eye, NumberParser().toSocialMediaString(views), Colors.blueGrey),
        _buildChip(Icons.monetization_on_outlined, NumberParser().toSocialMediaString(points), Colors.orange),
      ],
    );
  }

  Widget _buildDataShimmerChips() {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        _buildChipShimmer(Icons.shopping_bag, Colors.green),
        _buildChipShimmer(Icons.data_exploration, Colors.blue),
        _buildChipShimmer(Icons.remove_red_eye, Colors.blueGrey),
        _buildChipShimmer(Icons.monetization_on_outlined, Colors.orange),
      ],
    );
  }

  Container _buildChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: Colors.grey)),
      child: IntrinsicWidth(
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: color,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

Container _buildChipShimmer(IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(width: 1, color: Colors.grey)),
    child: IntrinsicWidth(
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: color,
          ),
          const SizedBox(
            width: 8,
          ),
          Shimmer.fromColors(
            baseColor: const Color(0xffd3d3d3),
            highlightColor: const Color(0x0fe6e1e1),
            child: Container(
              width: 30,
              height: 20,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
          )
        ],
      ),
    ),
  );
}