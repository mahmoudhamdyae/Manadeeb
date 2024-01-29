import 'package:flutter/cupertino.dart';
import 'package:manadeeb/domain/models/order_details.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/order_details/widgets/notes_grid_view.dart';

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
          Text(
            AppStrings.notes,
            style: getLargeStyle(),
          ),
          NotesGridView(orderDetails: order.orderdetails ?? []),
        ],
      ),
    );
  }
}
