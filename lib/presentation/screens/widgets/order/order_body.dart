import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/domain/models/order_response.dart';
import 'package:manadeeb/presentation/resources/color_manager.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../resources/constants_manager.dart';

class OrderBody extends StatelessWidget {

  final Order order;
  const OrderBody({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.buyer ?? '',
                  style: getLargeStyle(),
                ),
                const SizedBox(height: 8.0,),
                Text(
                  order.phone ?? '',
                  style: getSmallStyle(
                    color: ColorManager.grey,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${order.priceAll ?? ''} د.ك',
                  style: getLargeStyle(
                    color: ColorManager.secondary,
                  ),
                ),
                const SizedBox(height: 8.0,),
                Text(
                  order.address ?? '',
                  style: getSmallStyle(
                    color: ColorManager.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8.0,),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                style: getFilledButtonStyle(
                  color: ColorManager.green,
                ),
                  onPressed: () => call(order.phone ?? ''),
                  child: Text(
                    AppStrings.call,
                    style: getSmallStyle(
                      color: ColorManager.white,
                    ),
                  ),
              ),
            ),
            const SizedBox(width: 16.0,),
            Expanded(
              child: OutlinedButton(
                style: getOutlinedButtonStyle(color: ColorManager.green,),
                onPressed: () => openWhatsapp(order.phone ?? ''),
                child: Text(
                  AppStrings.whats,
                  style: getSmallStyle(),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

void call(String number) {
  launch("tel://$number");
}
openWhatsapp(String number) async {
  var whatsapp ="+965${replaceFarsiNumber(number)}";
  final Uri url = Uri.parse('https://wa.me/$whatsapp');
  if (!await launchUrl(url)) {
    Get.showSnackbar(
      const GetSnackBar(
        title: null,
        message: AppStrings.noWhats,
        duration: Duration(seconds: AppConstants.snackBarTime),
      ),
    );
  }
}

String replaceFarsiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '٤', '٥', '۶', '٧', '۸', '٩'];

  for (int i = 0; i < 10; i++) {
    input = input.replaceAll(farsi[i], english[i]);
  }

  return input;
}
