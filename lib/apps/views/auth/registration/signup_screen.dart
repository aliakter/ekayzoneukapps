import 'package:ekayzoneukapps/apps/core/utils/colors.dart';
import 'package:ekayzoneukapps/apps/core/utils/custom_image.dart';
import 'package:ekayzoneukapps/apps/data/remote_urls.dart';
import 'package:ekayzoneukapps/apps/views/auth/registration/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/k_images.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: AppColors.black,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: Get.size.height * 0.02)),

            ///TOP HEADER
            const SliverPadding(
              padding: EdgeInsets.symmetric(),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomImage(
                      height: 80,
                      width: 150,
                      fit: BoxFit.cover,
                      path: KImages.allAppLogo,
                    ),
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 50)),

            ///Text input fields
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text('Name'),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: controller.nameCtl,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Enter your name",
                      ),
                    ),
                    const SizedBox(height: 16),
                    // const Text('Username'),
                    // const SizedBox(height: 5),
                    // TextFormField(
                    //   controller: controller.userNameCtrl,
                    //   keyboardType: TextInputType.text,
                    //   textInputAction: TextInputAction.next,
                    //   decoration: const InputDecoration(
                    //     hintText: "Enter your username",
                    //   ),
                    // ),
                    // const SizedBox(height: 16),
                    const Row(
                      children: [
                        Text('Email'),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: controller.emailCtl,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: "Enter your email",
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Text('Password'),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Obx(() {
                      return TextFormField(
                        controller: controller.passwordCtl,
                        obscureText: controller.obscureText.value,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "Enter your password",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                controller.toggle();
                              },
                              child: controller.obscureText.value
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.black87,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: Colors.black87,
                                    ),
                            )),
                      );
                    }),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Text('Confirm password'),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Obx(() {
                      return TextFormField(
                        controller: controller.confPasswordCtl,
                        obscureText: controller.obscureConfirmText.value,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: "Enter your confirm password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              controller.toggleConfirm();
                            },
                            child: controller.obscureConfirmText.value
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black87,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.black87,
                                  ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                    Obx(
                      () => CheckboxListTile(
                        value: controller.agree.value == 1,
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        checkColor: Colors.white,
                        activeColor: redColor,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (value) {
                          controller.checkBox();
                        },
                        title: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'I Agree To The ',
                                  style: TextStyle(
                                      color: blackColor.withOpacity(.5),
                                      fontSize: 12),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      launchUrl(
                                        Uri.parse(RemoteUrls.termsAndCondition),
                                      );
                                    },
                                    child: const Text(
                                      'Terms & Conditions',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xFF212D6E),
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'And ',
                                  style: TextStyle(
                                      color: blackColor.withOpacity(.5),
                                      fontSize: 12),
                                ),
                                InkWell(
                                  onTap: () {
                                    launchUrl(
                                      Uri.parse(RemoteUrls.privacyPolicy),
                                    );
                                  },
                                  child: const Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                        color: Color(0xFF212D6E), fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            ///Register BTN
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      elevation: 5,
                      shadowColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    onPressed: () {
                      controller.userRegistration();
                    },
                    child: Obx(
                      () => Center(
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Already have an account?"),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: redColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
            // const SliverToBoxAdapter(
            //   child: Center(
            //     child: Text(
            //       'or',
            //       style: TextStyle(
            //           fontWeight: FontWeight.w600,
            //           color: Colors.grey,
            //           fontSize: 18),
            //     ),
            //   ),
            // ),
            // const SliverToBoxAdapter(child: SizedBox(height: 20)),
            // SliverToBoxAdapter(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       InkWell(
            //         onTap: () {
            //           controller.handleGoogleSignIn();
            //         },
            //         child: Obx(
            //           () => controller.isGmailLoading.value
            //               ? const Center(child: CircularProgressIndicator())
            //               : Container(
            //                   padding: const EdgeInsets.all(18),
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(100),
            //                     image: const DecorationImage(
            //                       image: AssetImage("assets/social/google.png"),
            //                     ),
            //                   ),
            //                 ),
            //         ),
            //       ),
            //       // const SizedBox(width: 16),
            //       // InkWell(
            //       //   onTap: () async {
            //       //     UserCredential? userCredential =
            //       //         await controller.handleFbSignIn();
            //       //     if (userCredential != null) {
            //       //       log("================>>> FB Signed in: ${userCredential.user!.displayName}");
            //       //     }
            //       //   },
            //       //   child: Container(
            //       //     padding: const EdgeInsets.all(18),
            //       //     decoration: BoxDecoration(
            //       //       borderRadius: BorderRadius.circular(100),
            //       //       image: const DecorationImage(
            //       //         image: AssetImage("assets/social/facebook.png"),
            //       //       ),
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            // const SliverToBoxAdapter(child: SizedBox(height: 25)),
          ],
        ),
      );
    });
  }
}
