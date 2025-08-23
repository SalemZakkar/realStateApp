import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/home/presentation/page/home_page.dart';

class SplashPage extends StatefulWidget {
  static const String path = '/splashPage';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e){
      context.go(HomePage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
