import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/core/utils/custom_image.dart';
import 'package:ekayzoneukapps/apps/core/utils/k_images.dart';
import 'package:ekayzoneukapps/apps/routes/routes.dart';
import 'package:ekayzoneukapps/apps/views/chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/utils/utils.dart';
import '../../data/remote_urls.dart';
import '../splash/localization/app_localizations.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Chats"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => Future.delayed(
                    const Duration(seconds: 1), () => controller.getChatList()),
                child: controller.chatListModel!.data.users.isNotEmpty
                    ? CustomScrollView(
                        scrollDirection: Axis.vertical,
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount:
                                  controller.chatListModel!.data.users.length,
                              (context, index) {
                                return Material(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.chatDetails,
                                        arguments: controller.chatListModel!
                                            .data.users[index].username,
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(height: 8.h),
                                        IntrinsicHeight(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: redColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: CustomImage(
                                                      path: controller
                                                                  .chatListModel!
                                                                  .data
                                                                  .users[index]
                                                                  .image !=
                                                              ''
                                                          ? '${RemoteUrls.rootUrl}${controller.chatListModel!.data.users[index].image}'
                                                          : null,
                                                      height: 50.h,
                                                      width: 50.h,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .chatListModel!
                                                          .data
                                                          .users[index]
                                                          .name,
                                                      style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14.sp,
                                                        height: 1.h,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    Text(
                                                      controller
                                                          .chatListModel!
                                                          .data
                                                          .users[index]
                                                          .body,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 12.sp,
                                                        height: 1.h,
                                                      ),
                                                    ),
                                                    Text(
                                                      Utils.timeAgo(controller
                                                          .chatListModel!
                                                          .data
                                                          .users[index]
                                                          .createdAt
                                                          .toString()),
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 10.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Divider(height: 1.h)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(top: 200.h),
                          child: Image.asset(KImages.noDataImage),
                        ),
                      ),
              );
      }),
    );
  }
}
