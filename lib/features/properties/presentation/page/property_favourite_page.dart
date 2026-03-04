import 'package:flutter/material.dart';

class PropertyFavouritePage extends StatefulWidget {
  static String path = "/PropertyFavouritePage";

  const PropertyFavouritePage({super.key});

  @override
  State<PropertyFavouritePage> createState() => _PropertyFavouritePageState();
}

class _PropertyFavouritePageState extends State<PropertyFavouritePage> {
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
