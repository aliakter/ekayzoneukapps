import 'package:ekayzoneukapps/apps/core/utils/utils.dart';
import 'package:ekayzoneukapps/apps/views/ad_post/controller/ad_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';

class FeaturedScreen extends StatelessWidget {
  const FeaturedScreen({super.key, required this.controller});

  final AdPostController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feature Payment"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: Get.width / 2 - 21,
                            color: Colors.grey.shade300,
                            child: const Text('Ad Title')),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: Get.width / 2 - 21,
                            child: const Text('Category')),
                        Container(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            width: Get.width / 2 - 21,
                            color: Colors.grey.shade300,
                            child: const Text('Request for Payment:')),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: Get.width / 2 - 21,
                            child: const Text('Duration')),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: Get.width / 2 - 21,
                            color: Colors.grey.shade300,
                            child: const Text('Amount')),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: Get.width / 2 - 21,
                            color: Colors.grey.shade300,
                            child: Text(
                              controller.titleController.text.trim(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: Get.width / 2 - 21,
                            child:
                                Text(controller.selectedCategory.value!.name)),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: Get.width / 2 - 21,
                            color: Colors.grey.shade300,
                            child: const Text('Ad Promotion')),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: Get.width / 2 - 21,
                            child: Text(
                                '${controller.priority.value!.duration} days')),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: Get.width / 2 - 21,
                            color: Colors.grey.shade300,
                            child: Text(
                                '£ ${controller.priority.value!.price.toStringAsFixed(2)}')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Pay with Paypal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              SizedBox(
                height: 45,
                width: Get.width / 2,
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      Utils.closeKeyBoard(context);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            // PaypalCheckoutView(
                            PaypalCheckout(
                                sandboxMode: controller
                                        .settingsData.value!.paypal.paypalMode ==
                                    'sandbox',
                                clientId:
                                    // "AaDs0a6Byk0VsjLoTqIySGmKDsNRLGkVKOlvm95kMmq9reGeiRhfZZeCd6T7PMZVu9pZEZA7Q0sVvErB",
                                    controller.settingsData.value!.paypal
                                                .paypalMode !=
                                            'sandbox'
                                        ? controller.settingsData.value!.paypal
                                            .paypalLiveClientId
                                        : controller.settingsData
                                            .value!.paypal.paypalSandboxClientId,
                                secretKey:
                                    // "EAlXhR2DimyF8_J6yIOViOsb2gj-3AZLgRK4LfcKQILQxAlmYwU_CUKzPb36Wj9mi8VEacjFUKV6-XAs",
                                    controller.settingsData.value!.paypal
                                                .paypalMode !=
                                            'sandbox'
                                        ? controller.settingsData.value!.paypal
                                            .paypalLiveClientSecret
                                        : controller.settingsData.value!.paypal
                                            .paypalSandboxClientSecret,
                                returnURL: 'ekayzone.co.uk',
                                cancelURL: 'cancel.snippetcoder.com',
                                transactions: [
                                  {
                                    "amount": {
                                      "total":
                                          '${controller.priority.value!.price}',
                                      "currency": "EUR",
                                      "details": {
                                        "subtotal":
                                            '${controller.priority.value!.price}',
                                        "shipping": '0',
                                        "shipping_discount": 0
                                      }
                                    },
                                    "description":
                                        "The payment transaction description.",
                                    "item_list": {
                                      "items": [
                                        {
                                          "name": "Ad Promotion",
                                          "quantity": 1,
                                          "price":
                                              '${controller.priority.value!.price}',
                                          "currency": "EUR"
                                        }
                                      ],
                                      // shipping address is Optional
                                      "shipping_address": {
                                        "recipient_name": "Raman Singh",
                                        "line1": "Delhi",
                                        "line2": "",
                                        "city": "Delhi",
                                        "country_code": "IN",
                                        "postal_code": "11001",
                                        "phone": "+00000000",
                                        "state": "Texas"
                                      },
                                    }
                                  }
                                ],
                                note: "PAYMENT_NOTE",
                                onSuccess: (Map params) async {
                                  for (var element in params.entries) {
                                    if (element.key == 'data') {
                                      print(element.value['transactions'][0]
                                              ['related_resources'][0]['sale']
                                          ['id']);
                                      controller.paypalPaymentSuccess(
                                          element.value['transactions'][0]
                                                  ['related_resources'][0]
                                              ['sale']['id']);
                                    }
                                  }
                                },
                                onError: (error) {
                                  Utils.toastMsg(error.toString());
                                  Navigator.pop(context);
                                },
                                onCancel: () {
                                  Utils.toastMsg('cancelled');
                                }),
                      ));
                    },
                    child: controller.isPostAdsLoading.value
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : const Text(
                            'Pay Now',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
