import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/core/utils/custom_image.dart';
import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/data/remote_urls.dart';
import 'package:ekayzoneukapps/apps/views/chat_details/controller/chat_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatDetailsScreen extends GetView<ChatDetailsController> {
  const ChatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ashColor,
      body: SafeArea(
        child: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    ///App Bar
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 2,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(3),
                                      decoration: const BoxDecoration(
                                        color: redColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CustomImage(
                                          path: controller
                                                      .chatDetailsModel
                                                      .value!
                                                      .data
                                                      .selectedUser
                                                      .image !=
                                                  ''
                                              ? "${RemoteUrls.rootUrl}${controller.chatDetailsModel.value!.data.selectedUser.image}"
                                              : null,
                                          height: 50.h,
                                          width: 50.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          controller.chatDetailsModel.value!
                                              .data.selectedUser.name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          controller.chatDetailsModel.value!
                                              .data.selectedUser.email,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                InkWell(
                                  child: const Icon(Icons.close),
                                  onTap: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        reverse: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ListView.separated(
                          shrinkWrap: true,
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller
                              .chatDetailsModel.value!.data.messages.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8);
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 3),
                              child: Row(
                                mainAxisAlignment: controller.isMe(controller
                                        .chatDetailsModel
                                        .value!
                                        .data
                                        .messages[index]
                                        .fromId)
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: controller.isMe(
                                            controller.chatDetailsModel.value!
                                                .data.messages[index].fromId)
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 6),
                                        decoration: BoxDecoration(
                                            color: controller.isMe(controller
                                                    .chatDetailsModel
                                                    .value!
                                                    .data
                                                    .messages[index]
                                                    .fromId)
                                                ? Colors.white
                                                : Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(10),
                                              topRight:
                                                  const Radius.circular(10),
                                              bottomRight: index % 2 == 0
                                                  ? const Radius.circular(10)
                                                  : const Radius.circular(10),
                                              bottomLeft:
                                                  const Radius.circular(0),
                                            )),
                                        child: Text(
                                          controller.chatDetailsModel.value!
                                              .data.messages[index].body,
                                          style: TextStyle(
                                              color: controller.isMe(controller
                                                      .chatDetailsModel
                                                      .value!
                                                      .data
                                                      .messages[index]
                                                      .fromId)
                                                  ? Colors.black
                                                  : Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      controller.isMe(controller
                                              .chatDetailsModel
                                              .value!
                                              .data
                                              .messages[index]
                                              .fromId)
                                          ? Row(
                                              children: [
                                                Text(
                                                  Utils.timeAgo(controller
                                                      .chatDetailsModel
                                                      .value!
                                                      .data
                                                      .messages[index]
                                                      .createdAt
                                                      .toString()),
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                const SizedBox(width: 3),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
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
                                                                  .chatDetailsModel
                                                                  .value!
                                                                  .data
                                                                  .user
                                                                  .image !=
                                                              ''
                                                          ? "${RemoteUrls.rootUrl}${controller.chatDetailsModel.value!.data.user.image}"
                                                          : null,
                                                      height: 18.h,
                                                      width: 18.h,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
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
                                                                  .chatDetailsModel
                                                                  .value!
                                                                  .data
                                                                  .selectedUser
                                                                  .image !=
                                                              ''
                                                          ? "${RemoteUrls.rootUrl}${controller.chatDetailsModel.value!.data.selectedUser.image}"
                                                          : null,
                                                      height: 18.h,
                                                      width: 18.h,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                Text(
                                                  Utils.timeAgo(controller
                                                      .chatDetailsModel
                                                      .value!
                                                      .data
                                                      .messages[index]
                                                      .createdAt
                                                      .toString()),
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(color: ashColor, boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 2,
                            offset: const Offset(0, -5))
                      ]),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.messageCtr,
                              textInputAction: TextInputAction.send,
                              decoration: InputDecoration(
                                hintText: "Type your message",
                                hintStyle: const TextStyle(fontSize: 14),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Obx(
                            () => controller.isLoadingSend.value
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : GestureDetector(
                                    onTap: () {
                                      controller.sendMessage();
                                    },
                                    child: const Icon(
                                      Icons.send,
                                      color: redColor,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
        }),
      ),
    );
  }
}
