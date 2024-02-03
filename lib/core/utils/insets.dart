import 'package:flutter/cupertino.dart';

abstract class Insets {
  static const scale = 1.0;
  static double get small => 8 * scale;
  static double get medium => 12 * scale;
  static double get large => 16 * scale;
}

bool isWide(BuildContext context) {
  return MediaQuery.of(context).size.width >= 600;
}