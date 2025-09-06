import 'package:flutter/material.dart';
import 'package:real_state/features/core/domain/enum/contact_type.dart';
import 'package:real_state/features/core/presentation/cubit/contact_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/consumer_widget.dart';
import 'package:real_state/features/core/presentation/widget/contact_us_card.dart';

import '../../../../injection.dart';
import '../widget/custom_card_widget.dart';

class SettingsPage extends StatefulWidget {
  static String path = '/settings_page';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final contact = getIt<ContactCubit>();

  @override
  void initState() {
    super.initState();
    contact.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translation.contactUs),
        centerTitle: true,
      ),
      body: ConsumerWidget(
        autoDispose: false,
        cubit: contact,
        childBuilder: (context, c) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            constraints: const BoxConstraints.expand(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomCardWidget(
                    padding: EdgeInsets.only(
                      top: 16,
                      bottom: 0,
                      left: 16,
                      right: 16,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          for (var type in ContactType.values) ...[
                            for (var e in c) ...[
                              if (e.type == type) ...[
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: ContactUsCard(contactItem: e),
                                ),
                                16.height(),
                              ],
                            ],
                          ],

                          // ListTile(

                          //   title: Text(context.translation.phone),
                          // ),
                          // ListTile(
                          //   leading: Icon(
                          //     Icons.phone_android,
                          //     color: Theme.of(context).primaryColor,
                          //   ),
                          //   title: Text(context.translation.phone),
                          // ),
                        ],
                      ),
                    ),
                  ),

                  100.height(),
                ],
              ),
            ),
          );
        },
        onRetry: () {
          contact.start();
        },
      ),
    );
  }
}
