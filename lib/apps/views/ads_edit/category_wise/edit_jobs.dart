import 'dart:io';
import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/core/utils/custom_image.dart';
import 'package:ekayzoneukapps/apps/data/remote_urls.dart';
import 'package:ekayzoneukapps/apps/global_widget/categories_model.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/controller/ad_edit_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/models/designation_model.dart';
import 'package:ekayzoneukapps/apps/views/home/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EditJobsField extends StatefulWidget {
  const EditJobsField({Key? key, required this.controller}) : super(key: key);
  final AdEditController controller;

  @override
  State<EditJobsField> createState() => _JobsFieldState();
}

class _JobsFieldState extends State<EditJobsField> {
  bool applicationAlertEmail = true;
  bool applicationAlertPhone = true;

  String groupValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text("Designation", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 7),
        DropdownButtonFormField<Designations>(
          isExpanded: true,
          decoration: const InputDecoration(
            hintText: "Designation",
          ),
          value: widget.controller.designationsModel,
          items: widget.controller.designationsList.value
              .map<DropdownMenuItem<Designations>>((e) {
            return DropdownMenuItem<Designations>(
              value: e,
              child: Text(e.title ?? ""),
            );
          }).toList(),
          onChanged: (Designations? value) {
            widget.controller.selectedDesignation = value!.id.toString();
          },
        ),
        const SizedBox(height: 16),
        const Text("Job type", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 7),
        DropdownButtonFormField(
          decoration: const InputDecoration(hintText: "Select job type"),
          items: jobTypeList.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          value: widget.controller.jobType,
          onChanged: (value) {
            widget.controller.jobType = value!;
            widget.controller.selectedJobType = value;
          },
        ),
        const SizedBox(height: 16),
        const Text(
          "How do you want to receive applications?",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            SizedBox(
              width: 30,
              height: 24,
              child: Obx(() => Checkbox(
                    value: widget.controller.receiveIsEmail.value,
                    onChanged: (value) {
                      widget.controller.receiveIsEmail.value =
                          !widget.controller.receiveIsEmail.value;
                    },
                    activeColor: const Color(0xFF0b5ed7),
                  )),
            ),
            const Text(
              "Email and employer dashboard",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 30,
              height: 24,
              child: Obx(() => Checkbox(
                  value: widget.controller.receiveIsPhone.value,
                  onChanged: (value) {
                    widget.controller.receiveIsPhone.value =
                        !widget.controller.receiveIsPhone.value;
                  },
                  activeColor: const Color(0xFF0b5ed7))),
            ),
            const Text("Employer Phone", style: TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 16),
        Obx(() => Visibility(
          visible: widget.controller.receiveIsEmail.value,
          maintainAnimation: true,
          maintainState: true,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn,
            opacity: widget.controller.receiveIsEmail.value ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Employer email",style: TextStyle(fontSize: 16),),
                const SizedBox(
                  height: 7,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  // initialValue: state.phone,
                  controller: widget.controller.employerEmailController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if ((value == null||value.isEmpty) && widget.controller.receiveIsEmail.value) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),),
        Obx(() => Visibility(
          visible: widget.controller.receiveIsPhone.value,
          maintainAnimation: true,
          maintainState: true,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn,
            opacity: widget.controller.receiveIsEmail.value ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Employer phone",style: TextStyle(fontSize: 16),),
                const SizedBox(
                  height: 7,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  // initialValue: state.phone,
                  controller: widget.controller.employerPhoneController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if ((value == null||value.isEmpty) && widget.controller.receiveIsPhone.value) {
                      return 'Please enter phone';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "Phone"),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),),
        const Text(
          "Required work experience (years)",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 7),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          controller: widget.controller.experienceController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {},
          decoration: const InputDecoration(
            hintText: "Years",
          ),
        ),
        const SizedBox(height: 16),
        const Text("Required Education", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 7),
        DropdownButtonFormField(
          decoration: const InputDecoration(hintText: "Select education"),
          items: educationList.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          value: widget.controller.education,
          onChanged: (value) {
            widget.controller.education = value!;
            // widget.controller.selectedEducation = value;
          },
        ),
        const SizedBox(height: 16),
        const Text("Salary per month", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 7),
        const Row(
          children: [
            Expanded(
              child: Text("From", style: TextStyle(fontSize: 16)),
            ),
            Expanded(
              child: Text("To", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: widget.controller.salaryFromController,
                onChanged: (value) {},
                decoration: const InputDecoration(hintText: "From"),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: widget.controller.salaryToController,
                onChanged: (value) {},
                decoration: const InputDecoration(hintText: "To"),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        const Text("Application deadline", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 7),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.datetime,
          controller: widget.controller.expiryDateController,
          onChanged: (value) {},
          readOnly: true,
          onTap: () {
            widget.controller.chooseDate(context);
          },
          decoration: const InputDecoration(hintText: "MM/DD/YYYY"),
        ),
        const SizedBox(height: 16),
        const Text("Employer Name", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 7),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
          controller: widget.controller.employerNameController,
          onChanged: (value) {},
          decoration: const InputDecoration(hintText: "Employer Name"),
        ),
        const SizedBox(height: 16),
        const Text("Employer Website", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 7),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.url,
          controller: widget.controller.webSiteController,
          onChanged: (value) {},
          decoration: const InputDecoration(hintText: "Employer Website"),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: SizedBox(
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  widget.controller.pickLogoImage().then((value) {
                    if (value != null) {
                      setState(() {});
                    }
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text("Attach Logo"),
              ),
            )),
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: widget.controller.adEditModel?.employerLogo == ""
                      ? Image(
                          image: FileImage(
                              File(widget.controller.logoImage?.path ?? "")),
                          fit: BoxFit.contain,
                        )
                      : CustomImage(
                          path:
                              "${RemoteUrls.rootUrl}${widget.controller.adEditModel?.employerLogo}"),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
