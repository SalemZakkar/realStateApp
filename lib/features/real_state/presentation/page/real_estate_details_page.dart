import 'package:flutter/material.dart';

class RealEstateDetailsPage extends StatefulWidget {
  static const String path = '/real-estate-details';

  const RealEstateDetailsPage({super.key});

  @override
  State<RealEstateDetailsPage> createState() => _RealEstateDetailsPageState();
}

class _RealEstateDetailsPageState extends State<RealEstateDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(child: Column(children: [
          
        ])),
      ),
    );
  }
}
