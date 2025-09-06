import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/tutorial/presentation/page/tutorial_page.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';

class TutorialButton extends StatefulWidget {
  const TutorialButton({super.key});

  @override
  State<TutorialButton> createState() => _TutorialButtonState();
}

class _TutorialButtonState extends State<TutorialButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(TutorialPage.path);
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  const Color(0xFF3B82F6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  0.1 + (_controller.value * 0.4), // يتحرك بين 0.1 → 0.5
                  0.9 - (_controller.value * 0.4), // يتحرك بين 0.9 → 0.5
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Assets.icons.info.dynamicSVGColor(context, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    context.translation.tutorial,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_ios, color: Colors.white),
              ],
            ),
          );
        },
      ),
    );
  }
}
