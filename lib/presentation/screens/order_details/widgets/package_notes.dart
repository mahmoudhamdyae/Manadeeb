import 'package:flutter/cupertino.dart';
import 'package:manadeeb/domain/models/package.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class PackageNotes extends StatelessWidget {

  final List<PackageBook> books;
  const PackageNotes({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    books[index].name ?? '',
                    style: getLargeStyle(),
                  ),
                  Text(
                    '${books[index].bookPrice ?? ''} د.ك',
                    style: getLargeStyle(
                      color: ColorManager.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0,),
              Text(
                books[index].classroom ?? '',
                style: getSmallStyle(
                    color: ColorManager.grey
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
