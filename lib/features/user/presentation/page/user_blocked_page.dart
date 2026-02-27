import 'package:flutter/material.dart';

class UserBlockedPage extends StatefulWidget {
  static String path = "/UserBlockedPage";

  const UserBlockedPage({super.key});

  @override
  State<UserBlockedPage> createState() => _UserBlockedPageState();
}

class _UserBlockedPageState extends State<UserBlockedPage> {
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
