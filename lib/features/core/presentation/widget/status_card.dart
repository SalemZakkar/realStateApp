import 'package:flutter/material.dart';

class StatusCard extends StatefulWidget {
  final Color color;
  final String title;
  final EdgeInsets padding;

  const StatusCard({
    super.key,
    required this.color,
    required this.title,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  State<StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: widget.color.withValues(alpha: 0.15),
      ),
      padding: widget.padding,
      child: Text(widget.title, style: TextStyle(color: widget.color)),
    );
  }
}
