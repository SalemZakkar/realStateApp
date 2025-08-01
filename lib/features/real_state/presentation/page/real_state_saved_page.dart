import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/widget/log_in_widget.dart';

class RealStateSavedPage extends StatefulWidget {
  static String path = '/real_state_saved_page';

  const RealStateSavedPage({super.key});

  @override
  State<RealStateSavedPage> createState() => _RealStateSavedPageState();
}

class _RealStateSavedPageState extends State<RealStateSavedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LogInWidget(child: Container()));
  }
}
