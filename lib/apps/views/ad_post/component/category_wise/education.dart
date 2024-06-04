import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/views/ad_post/controller/ad_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Education extends StatelessWidget {
  const Education({super.key, required this.controller});

  final AdPostController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Textbook Type',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 6),
        Wrap(
          alignment: WrapAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                controller.changeEducation("College/University");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Radio(
                        activeColor: redColor,
                        value: "College/University",
                        groupValue: controller.selectedEducation.value,
                        onChanged: (value) {
                          controller.changeEducation("College/University");
                        },
                      )),
                  const Text("College/University"),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.changeEducation("School");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Radio(
                        activeColor: redColor,
                        value: "School",
                        groupValue: controller.selectedEducation.value,
                        onChanged: (value) {
                          controller.changeEducation("School");
                        },
                      )),
                  const Text("School"),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.changeEducation("Other");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Radio(
                        activeColor: redColor,
                        value: "Other",
                        groupValue: controller.selectedEducation.value,
                        onChanged: (value) {
                          controller.changeEducation("Other");
                        },
                      )),
                  const Text("Other"),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
