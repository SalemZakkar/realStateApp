import 'dart:io';

import 'package:flutter/material.dart';
import 'package:real_state/features/core/domain/entity/contact_item.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/widget/buttons/tile_button.dart';
import 'package:real_state/features/core/presentation/widget/contact_icon.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/enum/contact_type.dart';
import 'buttons/inkwell_without_feedback.dart';

class ContactUsCard extends StatefulWidget {
  final ContactItem contactItem;

  const ContactUsCard({super.key, required this.contactItem});

  @override
  State<ContactUsCard> createState() => _ContactUsCardState();
}

class _ContactUsCardState extends State<ContactUsCard> {
  @override
  Widget build(BuildContext context) {
    return InkWellWithoutFeedback(
      onTap: () {
        if (widget.contactItem.type == ContactType.whatsapp) {
          if (Platform.isAndroid) {
            launchUrl(
              Uri.parse(
                "https://wa.me/${widget.contactItem.value}/?text=hello",
              ),
            );
          } else {
            launchUrl(
              Uri.parse(
                "https://api.whatsapp.com/send?phone=${widget.contactItem.type}=hello",
              ),
            );
          }
          return;
        }
        if (widget.contactItem.type == ContactType.call) {
          launchUrl(Uri.parse("tel://${widget.contactItem.value}"));
          return;
        }
        if (widget.contactItem.type == ContactType.telegram) {
          launchUrl(Uri.parse("https://t.me/${widget.contactItem.value}"));
          return;
        }

        if (widget.contactItem.type == ContactType.facebook ||
            widget.contactItem.type == ContactType.instagram) {
          launchUrl(Uri.parse(widget.contactItem.value));
          return;
        }
      },
      child: TileButton(
        image: ContactIcon(contactType: widget.contactItem.type),
        title: widget.contactItem.title ?? widget.contactItem.value,
        icon: Assets.icons.send.dynamicSVGColor(
          context,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
