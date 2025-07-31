import 'package:flutter/material.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';

class RealStateMapPage extends StatefulWidget {
  static String path = '/real_state_map_page';

  const RealStateMapPage({super.key});

  @override
  State<RealStateMapPage> createState() => _RealStateMapPageState();
}

class _RealStateMapPageState extends State<RealStateMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Assets.icons.nazg.image()
          ],
        ),
      ),
    );
  }
}
