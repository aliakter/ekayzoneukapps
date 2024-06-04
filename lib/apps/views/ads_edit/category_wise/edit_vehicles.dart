import 'package:ekayzoneukapps/apps/core/utils/constants.dart';
import 'package:ekayzoneukapps/apps/global_widget/categories_model.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/controller/ad_edit_controller.dart';
import 'package:ekayzoneukapps/apps/views/home/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditVehiclesField extends StatefulWidget {
  const EditVehiclesField({super.key, required this.controller});

  final AdEditController controller;

  @override
  State<EditVehiclesField> createState() => _VehiclesFieldState();
}

class _VehiclesFieldState extends State<EditVehiclesField> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 16),
      const Text("Brand", style: TextStyle(fontSize: 16)),
      const SizedBox(height: 7),
      DropdownButtonFormField(
        isExpanded: true,
        decoration: const InputDecoration(hintText: "Select Brand"),
        value: widget.controller.brandModel.value,
        items: widget.controller.brandList.map<DropdownMenuItem<Branding>>((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e.name),
          );
        }).toList(),
        onChanged: (value) {
          // widget.controller.getModel();
          widget.controller.selectedBrand = value?.id.toString() ?? "";
          widget.controller.brandModel.value = value;
        },
      ),
      const SizedBox(height: 16),
      const Text("Model", style: TextStyle(fontSize: 16)),
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
        decoration: const InputDecoration(hintText: "Enter Model"),
      ),
      // Obx(
      //   () => DropdownButtonFormField(
      //     isExpanded: true,
      //     decoration: const InputDecoration(hintText: "Select Model"),
      //     value: widget.controller.model,
      //     items: widget.controller.modelList.map<DropdownMenuItem<Model>>((e) {
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
      // ),
      const SizedBox(height: 16),
      const Text("Trim Edition"),
      const SizedBox(height: 7),
      TextFormField(
        keyboardType: TextInputType.text,
        controller: widget.controller.trimEditionController,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(hintText: "Trim Edition"),
      ),
      const SizedBox(height: 16),
      const Text("Manufacture year"),
      const SizedBox(height: 7),
      TextFormField(
        keyboardType: TextInputType.text,
        controller: widget.controller.manufactureYearController,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(hintText: "Manufacture year"),
      ),
      const SizedBox(height: 16),
      const Text("Engine capacity"),
      const SizedBox(height: 7),
      TextFormField(
        keyboardType: TextInputType.text,
        controller: widget.controller.engineCapacityController,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(hintText: "Engine capacity"),
      ),
      const SizedBox(height: 16),
      const Text("Fuel type", style: TextStyle(fontSize: 16)),
      const SizedBox(height: 7),
      Wrap(
        alignment: WrapAlignment.start,
        children: [
          ...List.generate(fuelTypeList.length, (index) {
            return GestureDetector(
              onTap: () {
                if (widget.controller.fuelTypes
                    .any((element) => element == fuelTypeList[index]["name"])) {
                  widget.controller.fuelTypes
                      .remove(fuelTypeList[index]["name"].toString().trim());
                } else {
                  widget.controller.fuelTypes
                      .add(fuelTypeList[index]["name"].toString().trim());
                }
                setState(() {});
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                      activeColor: redColor,
                      side: const BorderSide(color: redColor, width: 2),
                      value: widget.controller.fuelTypes.any(
                          (element) => element == fuelTypeList[index]["name"]),
                      onChanged: (value) {
                        if (value!) {
                          widget.controller.fuelTypes.add(
                              fuelTypeList[index]["name"].toString().trim());
                        } else {
                          widget.controller.fuelTypes.remove(
                              fuelTypeList[index]["name"].toString().trim());
                        }
                        setState(() {});
                      }),
                  Text(index != 2 && index != 6
                      ? fuelTypeList[index]['name']![0]
                              .toString()
                              .toUpperCase()
                              .trim() +
                          fuelTypeList[index]['name']
                              .toString()
                              .substring(1)
                              .trim()
                      : fuelTypeList[index]['name']
                          .toString()
                          .toUpperCase()
                          .trim()),
                ],
              ),
            );
          })
        ],
      ),
      const SizedBox(height: 16),
      const Text("Transmission", style: TextStyle(fontSize: 16)),
      const SizedBox(height: 7),
      Wrap(
        alignment: WrapAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.controller.selectedTransmission = "manual";
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  activeColor: redColor,
                  value: "manual",
                  groupValue: widget.controller.selectedTransmission,
                  onChanged: (value) {
                    setState(() {
                      widget.controller.selectedTransmission = value.toString();
                    });
                  },
                ),
                const Text("Manual"),
                const SizedBox(width: 10),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.controller.selectedTransmission = "automatic";
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  activeColor: redColor,
                  value: "automatic",
                  groupValue: widget.controller.selectedTransmission,
                  onChanged: (value) {
                    setState(() {
                      widget.controller.selectedTransmission = value.toString();
                    });
                  },
                ),
                const Text("Automatic"),
                const SizedBox(width: 10),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.controller.selectedTransmission = "other_transmission";
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  activeColor: redColor,
                  value: "other_transmission",
                  groupValue: widget.controller.selectedTransmission,
                  onChanged: (value) {
                    setState(() {
                      widget.controller.selectedTransmission = value.toString();
                    });
                  },
                ),
                const Text("Other transmission"),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      const Text("Body Type"),
      const SizedBox(height: 7),
      DropdownButtonFormField(
        decoration: const InputDecoration(hintText: "Select Body Type"),
        items: vehicleBodyTypeList.map<DropdownMenuItem<String>>((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList(),
        onChanged: (value) {
          widget.controller.selectedBodyType = value.toString();
        },
      ),
      const SizedBox(height: 16),
      const Text("Registration year"),
      const SizedBox(height: 7),
      TextFormField(
        keyboardType: TextInputType.text,
        controller: widget.controller.registrationYearController,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(hintText: "Registration year"),
      ),
    ]);
  }
}
