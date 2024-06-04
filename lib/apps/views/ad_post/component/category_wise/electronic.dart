import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/views/ad_post/controller/ad_post_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElectronicField extends StatefulWidget {
  const ElectronicField({super.key, required this.controller});

  final AdPostController controller;

  @override
  State<ElectronicField> createState() => _ElectronicFieldState();
}

class _ElectronicFieldState extends State<ElectronicField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text("Authenticity", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 7),
        Wrap(
          alignment: WrapAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                widget.controller.changeAuthenticity("original");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Radio(
                        activeColor: redColor,
                        value: "original",
                        groupValue:
                            widget.controller.selectedAuthenticities.value,
                        onChanged: (value) {
                          widget.controller.changeAuthenticity(value);
                        },
                      )),
                  const Text("Original"),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.controller.changeAuthenticity('refurbished');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Radio(
                        activeColor: redColor,
                        value: "refurbished",
                        groupValue:
                            widget.controller.selectedAuthenticities.value,
                        onChanged: (value) {
                          widget.controller.changeAuthenticity(value);
                        },
                      )),
                  const Text("Refurbished"),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
        // const Text(
        //   "Brand",
        //   style: TextStyle(fontSize: 16),
        // ),
        // const SizedBox(height: 7),
        // DropdownButtonFormField(
        //   isExpanded: true,
        //   decoration: const InputDecoration(hintText: "Select Brand"),
        //   value: controller.brandModel,
        //   items: controller.brandList
        //       .map<DropdownMenuItem<BrandModel>>((e) {
        //     return DropdownMenuItem(
        //       value: e,
        //       child: Text(e.name),
        //     );
        //   }).toList(),
        //   onChanged: (value) {
        //     controller.getModel();
        //     Future.delayed(const Duration(milliseconds: 300)).then(
        //           (value2) {
        //         controller.selectedBrand = value?.id.toString() ?? "";
        //       },
        //     );
        //   },
        // ),
        const SizedBox(height: 16),
        const Text(
          "Model",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 7),
        TextFormField(
          keyboardType: TextInputType.name,
          controller: widget.controller.selectedModelElectronics,
          textInputAction: TextInputAction.next,
          validator: (value) {
            // if (value == null || value.isEmpty) {
            //   return 'Enter Model';
            // }
            return null;
          },
          decoration: const InputDecoration(hintText: "Model"),
        ),
        const SizedBox(height: 16),
        const Text(
          "Edition (optional)",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 7),
        TextFormField(
          keyboardType: TextInputType.name,
          controller: widget.controller.selectedEditionElectronics,
          textInputAction: TextInputAction.next,
          validator: (value) {
            // if (value == null || value.isEmpty) {
            //   return 'Enter the edition of your phone';
            // }
            return null;
          },
          decoration: const InputDecoration(
              hintText: "Enter the edition of your phone"),
        ),
        // Obx(
        //   () => DropdownButtonFormField(
        //     isExpanded: true,
        //     decoration: const InputDecoration(
        //       hintText: "Select Model",
        //     ),
        //     value: widget.controller.model,
        //     items:
        //         widget.controller.modelList.map<DropdownMenuItem<Model>>((e) {
        //       return DropdownMenuItem(
        //         value: e,
        //         child: Text(e.name),
        //       );
        //     }).toList(),
        //     onChanged: (value) {
        //       Future.delayed(const Duration(milliseconds: 300)).then(
        //         (value2) {
        //           widget.controller.selectedModel = value?.id.toString() ?? "";
        //         },
        //       );
        //     },
        //   ),
        // )
      ],
    );
  }
}
