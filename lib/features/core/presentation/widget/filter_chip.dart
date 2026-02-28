import 'package:flutter/material.dart';

class FilterChip extends StatefulWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const FilterChip({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  State<FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<FilterChip> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
