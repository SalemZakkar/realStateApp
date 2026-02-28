import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/themes/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPhoneButtons extends StatefulWidget {
  final String phone;

  const ContactUsPhoneButtons({super.key, required this.phone});

  @override
  State<ContactUsPhoneButtons> createState() => _ContactUsPhoneButtonsState();
}

class _ContactUsPhoneButtonsState extends State<ContactUsPhoneButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWellWithoutFeedback(
          onTap: () {
            launchUrl(Uri.parse("https://wa.me/${widget.phone}"));
          },
          child: Assets.icons.brandWhatsapp.dynamicSVGColor(context),
        ),
        16.width(),
        InkWellWithoutFeedback(
          onTap: () {
            launchUrl(Uri.parse("tel:${widget.phone}"));
          },
          child: Icon(
            Icons.phone,
            color: context.appColorSchema.shapeColors.iconColor,
          ),
        ),
      ],
    );
  }
}
