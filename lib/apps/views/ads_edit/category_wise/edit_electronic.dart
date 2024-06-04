import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/views/ad_post/controller/ad_post_controller.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/controller/ad_edit_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditElectronicField extends StatefulWidget {
  const EditElectronicField({super.key, required this.controller});

  final AdEditController controller;

  @override
  State<EditElectronicField> createState() => _ElectronicFieldState();
}

class _ElectronicFieldState extends State<EditElectronicField> {
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
                setState(() {
                  widget.controller.selectedAuthenticity.value = "original";
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                    activeColor: redColor,
                    value: "original",
                    groupValue: widget.controller.selectedAuthenticity.value,
                    onChanged: (value) {
                      setState(() {
                        widget.controller.selectedAuthenticity.value =
                            value.toString();
                      });
                    },
                  ),
                  const Text("Original"),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.controller.selectedAuthenticity.value = "refurbished";
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                    activeColor: redColor,
                    value: "refurbished",
                    groupValue: widget.controller.selectedAuthenticity.value,
                    onChanged: (value) {
                      setState(() {
                        widget.controller.selectedAuthenticity.value =
                            value.toString();
                      });
                    },
                  ),
                  const Text("Refurbished"),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
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
            if (value == null || value.isEmpty) {
              return 'Enter Model';
            }
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
            if (value == null || value.isEmpty) {
              return 'Enter the edition of your phone';
            }
            return null;
          },
          decoration: const InputDecoration(
              hintText: "Enter the edition of your phone"),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
