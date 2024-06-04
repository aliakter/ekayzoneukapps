import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/controller/ad_edit_controller.dart';
import 'package:flutter/material.dart';

class EditFashionField extends StatefulWidget {
  const EditFashionField({super.key, required this.controller});

  final AdEditController controller;

  @override
  State<EditFashionField> createState() => _FashionFieldState();
}

class _FashionFieldState extends State<EditFashionField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          "Type",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 7),
        DropdownButtonFormField(
          decoration: const InputDecoration(hintText: "Select Type"),
          value: widget.controller.selectedSize,
          items: typeList.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (value) {
            widget.controller.selectedSize = value.toString();
          },
        )
      ],
    );
  }
}
