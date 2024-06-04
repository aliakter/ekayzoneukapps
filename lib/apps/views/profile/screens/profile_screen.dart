import 'package:ekayzoneukapps/apps/routes/routes.dart';
import 'package:ekayzoneukapps/apps/views/main/controller/main_controller.dart';
import 'package:ekayzoneukapps/apps/views/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils/custom_image.dart';
import '../../../core/utils/k_images.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());
    ProfileController controller = Get.find();

    return controller.token == ""
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomImage(
                  height: 80,
                  width: 150,
                  fit: BoxFit.cover,
                  path: KImages.allAppLogo,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  width: 165,
                  child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      elevation: 5,
                      shadowColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      "Sign In Please",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      mainController.changePage(0);
                      Get.toNamed(Routes.login);
                    },
                  ),
                ),
              ],
            ),
          )
        : CustomScrollView(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              const SliverAppBar(title: Text("Overview"), pinned: true),
              _buildProfileOptions(context, controller),
              const SliverToBoxAdapter(child: SizedBox(height: 65)),
            ],
          );
  }

  SliverPadding _buildProfileOptions(
      BuildContext context, ProfileController controller) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Get.toNamed(Routes.dashBoard);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.home_outlined,
                size: 27,
                color: Colors.black54,
              ),
              title: const Text("Dashboard", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Get.toNamed(Routes.publicProfile,
                    arguments: controller.username);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.person_outline,
                size: 27,
                color: Colors.black54,
              ),
              title: const Text("My Shop", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Get.toNamed(Routes.adPostScreen);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.add_circle_outline_rounded,
                size: 27,
                color: Colors.black54,
              ),
              title: const Text("Ad Post", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Get.toNamed(Routes.customerAds);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.format_list_bulleted,
                size: 27,
                color: Colors.black54,
              ),
              title: const Text("My Ads", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Get.toNamed(Routes.compareAds);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.change_circle_outlined,
                size: 27,
                color: Colors.black54,
              ),
              title: const Text("Compare Ads", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Get.toNamed(Routes.favoriteAds);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.favorite_outline,
                size: 27,
                color: Colors.black54,
              ),
              title: const Text("Favourite Ads", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () {
                Get.toNamed(Routes.chat);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.chat_sharp,
                size: 27,
                color: Colors.black54,
              ),
              title: const Text("Chats", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.transaction);
              },
              leading: const Icon(
                Icons.article_outlined,
                color: Colors.black54,
              ),
              title: const Text("Transactions", style: TextStyle(fontSize: 16)),
            ),
            // ListTile(
            //   minLeadingWidth: 0,
            //   onTap: () {
            //     Get.toNamed(Routes.userPlan);
            //   },
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //   leading: const Icon(
            //     Icons.credit_card_outlined,
            //     color: Colors.black54,
            //   ),
            //   title:
            //       const Text("Plans & Billing", style: TextStyle(fontSize: 16)),
            // ),
            // ListTile(
            //   minLeadingWidth: 0,
            //   onTap: () {
            //     Get.toNamed(Routes.pricePlaning);
            //   },
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            //   leading: const Icon(
            //     Icons.monetization_on_outlined,
            //     color: Colors.black54,
            //   ),
            //   title: const Text("Pricing", style: TextStyle(fontSize: 16)),
            // ),
            ListTile(
              minLeadingWidth: 0,
              onTap: () async {
                await launchUrl(
                  Uri.parse("https://ekayzone.com/contact"),
                  webViewConfiguration: const WebViewConfiguration(
                    enableJavaScript: true,
                    enableDomStorage: true,
                  ),
                  mode: LaunchMode.externalApplication,
                );
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.contact_support_rounded,
                color: Colors.black54,
              ),
              title: const Text("Contact us", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(Routes.editProfile);
              },
              minLeadingWidth: 0,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.settings_outlined,
                size: 27,
                color: Colors.black54,
              ),
              title: const Text("Settings", style: TextStyle(fontSize: 16)),
            ),
            ListTile(
              minLeadingWidth: 0,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: const Icon(
                Icons.exit_to_app_outlined,
                size: 27,
                color: Colors.black54,
              ),
              title: const Text("Logout", style: TextStyle(fontSize: 16)),
              onTap: () {
                controller.showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
