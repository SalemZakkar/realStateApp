import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/real_state/presentation/page/real_state_map_page.dart';

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
      context.go(RealStateMapPage.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
