import 'package:flutter/material.dart';

class PropertyMapPage extends StatefulWidget {
  static String path = "/PropertyMapPage";

  const PropertyMapPage({super.key});

  @override
  State<PropertyMapPage> createState() => _PropertyMapPageState();
}

class _PropertyMapPageState extends State<PropertyMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //
            ],
          ),
        ),
      ),
    );
  }
}
