import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:manadeeb/domain/models/order_response.dart';
import 'package:manadeeb/presentation/resources/color_manager.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  onPressed: () {
                  call();
                  },
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
                onPressed: () {
                  whats(order.phone ?? '');
                },
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

void call() {
}

void whats(String number) async {
  // if (GetPlatform.isMobile) {
  //   final link = WhatsAppUnilink(
  //     phoneNumber: number,//'+001-(555)1234567',
  //     text: "Hey! I'm inquiring about the apartment listing",
  //   );
  //   await launchUrl(link.asUri());
  // }

  // await launch(
  //     "https://wa.me/${number}?text=Hello");

  // var whatsappUrl = Uri.parse(
  //     "whatsapp://send?phone=${'countryCodeText' + number}" +
  //         "&text=${Uri.encodeComponent("Your Message Here")}");
  // try {
  //   launchUrl(whatsappUrl);
  // } catch (e) {
  //   debugPrint(e.toString());
  // }

  // var whatsappUrl =
  //     "whatsapp://send?phone=+965$number";
  // launchUrl(whatsappUrl);
}
