import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/cubit/contact_cubit.dart';
import 'package:real_state/features/home/presentation/widget/bottom_bar.dart';
import 'package:real_state/injection.dart';

import 'home_page.dart';

class MainPage extends StatefulWidget {
  static String path = "/mainPage";
  final Widget child;

  const MainPage({super.key, required this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    getIt<ContactCubit>().start();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: GoRouter.of(context).state.path == HomePage.path,
      onPopInvokedWithResult: (k, r) {
        if (GoRouter.of(context).state.path != HomePage.path) {
          GoRouter.of(context).go(HomePage.path);
        }
      },
      child: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: [
              Positioned.fill(child: widget.child),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomBar(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
