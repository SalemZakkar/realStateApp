import 'package:flutter/material.dart';
import 'package:real_state/features/core/domain/entity/contact_item.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/widget/contact_icon.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:core_package/core_package.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/enum/contact_type.dart';

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
        if (widget.contactItem.type == ContactType.call) {
          launchUrl(Uri.parse("tel://${widget.contactItem.value}"));
          return;
        }

        if (widget.contactItem.type == ContactType.facebook ||
            widget.contactItem.type == ContactType.instagram) {
          launchUrl(Uri.parse(widget.contactItem.value));
          return;
        }
      },
      child: TileButton(
        leading: ContactIcon(contactType: widget.contactItem.type),
        title: widget.contactItem.type == ContactType.call
            ? widget.contactItem.value
            : widget.contactItem.type.name,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.end,
        trailing: Row(
          children: [
            InkWellWithoutFeedback(
              onTap: () {},
              child: Assets.icons.send.dynamicSVGColor(
                context,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            if (widget.contactItem.type == ContactType.call) ...[
              16.width(),
              InkWellWithoutFeedback(
                onTap: () {
                  launchUrl(Uri.parse("tel://${widget.contactItem.value}"));
                  return;
                },
                child: Assets.icons.brandWhatsapp.dynamicSVGColor(
                  context,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
