import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manadeeb/domain/models/order_details.dart';
import 'package:manadeeb/presentation/resources/color_manager.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/order_details/widgets/notes_list_view.dart';
import 'package:manadeeb/presentation/screens/order_details/widgets/packages_list_view.dart';

class OrderDetailsScreenBody extends StatelessWidget {

  final OrderDetailsResponse order;
  const OrderDetailsScreenBody({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          FilledButton(
            style: getFilledButtonStyle(),
            onPressed: () {
            },
            child: Text(
              AppStrings.receiveOrder,
              style: getLargeStyle(
                color: ColorManager.white,
              ),
            ),
          ),
          const SizedBox(height: 8.0,),
          order.orderdetails?[0].book == null ? Container() : Text(
            AppStrings.notes,
            style: getLargeStyle(),
          ),
          const SizedBox(height: 8.0,),
          NotesListView(orderDetails: order.orderdetails ?? []),
          const SizedBox(height: 16.0,),
          order.orderdetails?[0].package == null ? Container() : Text(
            AppStrings.packages,
            style: getLargeStyle(),
          ),
          const SizedBox(height: 8.0,),
          PackagesListView(orderDetails: order.orderdetails ?? []),
        ],
      ),
    );
  }
}
