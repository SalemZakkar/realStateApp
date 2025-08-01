import 'package:flutter/material.dart';

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
            // Assets.icons.nazg.image()
          ],
        ),
      ),
    );
  }
}
