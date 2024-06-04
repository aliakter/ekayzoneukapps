import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/controller/ad_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPropertyField extends StatefulWidget {
  const EditPropertyField({super.key, required this.controller});

  final AdEditController controller;

  @override
  State<EditPropertyField> createState() => _PropertyFieldState();
}

class _PropertyFieldState extends State<EditPropertyField> {
  String size = propertySizeList[0];
  String price = propertyPriceList[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text("Property Type", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 7),
        Wrap(
          alignment: WrapAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                widget.controller.changeSelectedProperty('agricultural');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Radio(
                        activeColor: redColor,
                        value: "agricultural",
                        groupValue:
                            widget.controller.selectedPropertyType.value,
                        onChanged: (value) {
                          widget.controller.changeSelectedProperty(value);
                        },
                      )),
                  const Text("Agricultural"),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.controller.changeSelectedProperty("residential");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Radio(
                        activeColor: redColor,
                        value: "residential",
                        groupValue:
                            widget.controller.selectedPropertyType.value,
                        onChanged: (value) {
                          widget.controller.changeSelectedProperty(value);
                        },
                      )),
                  const Text("Residential"),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.controller.changeSelectedProperty("commercial");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Radio(
                        activeColor: redColor,
                        value: "commercial",
                        groupValue:
                            widget.controller.selectedPropertyType.value,
                        onChanged: (value) {
                          widget.controller.changeSelectedProperty(value);
                        },
                      )),
                  const Text("Commercial"),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.controller.changeSelectedProperty("other");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                    activeColor: redColor,
                    value: "other",
                    groupValue: widget.controller.selectedPropertyType.value,
                    onChanged: (value) {
                      widget.controller.changeSelectedProperty(value);
                    },
                  ),
                  const Text("Other"),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text("Size", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 7),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: widget.controller.sizeController,
                onChanged: (value) {},
                decoration: const InputDecoration(
                  hintText: "What's the size of your land?",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: ashColor),
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(4))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ashColor),
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(4))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ashColor),
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(4))),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Obx(() => DropdownButtonFormField(
                    value: widget.controller.selectedPropertySize.value,
                    decoration: const InputDecoration(
                      fillColor: ashColor,
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(4))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(4))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(4))),
                    ),
                    items: propertySizeList.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (value) {
                      widget.controller.changePropertySize(value);
                    },
                  )),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // const Text("Bedroom"),
        // const SizedBox(height: 7),
        // TextFormField(
        //   keyboardType: TextInputType.text,
        //   controller: widget.controller.bedroomController,
        //   textInputAction: TextInputAction.next,
        //   decoration: const InputDecoration(hintText: "Enter Bedroom"),
        // ),
        // const SizedBox(height: 16),
        // const Text("Property Location"),
        // const SizedBox(height: 7),
        // TextFormField(
        //   keyboardType: TextInputType.text,
        //   controller: widget.controller.propertyLocationController,
        //   textInputAction: TextInputAction.next,
        //   decoration:
        //       const InputDecoration(hintText: "Enter property location"),
        // ),
        // const SizedBox(height: 16),
        const Text("Price", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 7),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: widget.controller.propertyPriceController,
                onChanged: (value) {},
                decoration: const InputDecoration(
                  hintText: "Property price",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: ashColor),
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(4))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ashColor),
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(4))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ashColor),
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(4))),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Obx(() => DropdownButtonFormField(
                    value: widget.controller.selectedPropertyPrice.value,
                    decoration: const InputDecoration(
                      fillColor: ashColor,
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(4))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(4))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(4))),
                    ),
                    items: propertyPriceList.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (value) {
                      widget.controller.changePropertyPrice(value);
                    },
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
