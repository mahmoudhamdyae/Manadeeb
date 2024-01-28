import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/assets_manager.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffE4E4E4),
      ),
      child: SvgPicture.asset(
        ImageAssets.user,
        height: 30,
        width: 24,
      ),
    );
  }
}
