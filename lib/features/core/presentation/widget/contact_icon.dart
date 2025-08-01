import 'package:flutter/material.dart';
import 'package:real_state/features/core/domain/enum/contact_type.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';

import '../../../../generated/generated_assets/assets.gen.dart';

class ContactIcon extends StatefulWidget {
  final ContactType contactType;
  final Color? color;
  final double? size;

  const ContactIcon({
    super.key,
    required this.contactType,
    this.color,
    this.size,
  });

  @override
  State<ContactIcon> createState() => _ContactIconState();
}

class _ContactIconState extends State<ContactIcon> {
  @override
  Widget build(BuildContext context) {
    return switch (widget.contactType) {
      ContactType.whatsapp => Assets.icons.brandWhatsapp.dynamicSVGColor(
        context,
        color: widget.color,
        width: widget.size,
        height: widget.size,
      ),
      ContactType.facebook => Assets.icons.facebook.dynamicSVGColor(
        context,
        color: widget.color,
        width: widget.size,
        height: widget.size,
      ),
      ContactType.call => Assets.icons.phoneCall.dynamicSVGColor(
        context,
        color: widget.color,
        width: widget.size,
        height: widget.size,
      ),
      ContactType.telegram => Assets.icons.brandTelegram.dynamicSVGColor(
        context,
        color: widget.color,
        width: widget.size,
        height: widget.size,
      ),
      ContactType.instagram => Assets.icons.instagram.dynamicSVGColor(
        context,
        color: widget.color,
        width: widget.size,
        height: widget.size,
      ),
    };
  }
}
