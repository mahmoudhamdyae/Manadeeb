import 'package:flutter/cupertino.dart';

import '../../../../domain/models/order_details.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class NotesListView extends StatelessWidget {

  final List<Orderdetails> orderDetails;
  const NotesListView({super.key, required this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: orderDetails[0].book == null ? 0 : 100,
      child: ListView.builder(
        itemCount: orderDetails[0].book == null ? 0 : orderDetails.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              border: Border.all(
                color: ColorManager.lightGrey,
                width: 1,
              ),
            ),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    orderDetails[index].book?.name ?? '',
                    style: getLargeStyle(),
                  ),
                  const SizedBox(width: 16.0,),
                  Text(
                    '${orderDetails[index].book?.bookPrice ?? ''} د.ك',
                    style: getLargeStyle(
                      color: ColorManager.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0,),
              Text(
                'الكمية: ${orderDetails[index].quantity ?? 1}',
                style: getSmallStyle(
                    color: ColorManager.grey
                ),
              ),
            ],
          ),
          );
        },
      ),
    );
  }
}
