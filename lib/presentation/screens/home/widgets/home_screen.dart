import 'package:flutter/material.dart';
import 'package:manadeeb/presentation/screens/widgets/home_app_bar/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          HomeAppBar(),
        ],
      ),
    );
  }
}
