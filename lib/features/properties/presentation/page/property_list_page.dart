import 'package:flutter/material.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';
import 'package:real_state/features/properties/presentation/widget/property_list_widget.dart';

class PropertyListPage extends StatefulWidget {
  static String path = "/PropertyList";
  static String shell = "/PropertyListShell";
  final PropertyGetParams? params;

  const PropertyListPage({super.key, this.params});

  @override
  State<PropertyListPage> createState() => _PropertyListPageState();
}

class _PropertyListPageState extends State<PropertyListPage> {
  PropertyGetParams? params = PropertyGetParams(skip: 0, limit: 2);

  @override
  void initState() {
    super.initState();
    if (widget.params != null) {
      params = widget.params!.clone();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: PropertyListWidget(
          params: widget.params ?? PropertyGetParams(skip: 0, limit: 10),
        ),
      ),
    );
  }
}
