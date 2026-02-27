import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/auth/presentation/page/auth_login_page.dart';
import 'package:real_state/features/core/domain/enum/contact_type.dart';
import 'package:real_state/features/core/presentation/cubit/contact_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/user_builder.dart';
import 'package:real_state/features/core/presentation/widget/contact_us_card.dart';
import 'package:real_state/features/user/presentation/widget/user_profile_card.dart';

import '../../../../injection.dart';

class SettingsPage extends StatefulWidget {
  static String path = '/settings_page';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final contact = getIt<ContactCubit>();
  var cubit = getIt<ContactCubit>()..start();

  @override
  void initState() {
    super.initState();
    contact.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Maison'), centerTitle: true),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserBuilder(
                builder: (context, state) {
                  return UserProfileCard(user: state);
                },
                unAuthWidget: Column(
                  children: [
                    Icon(
                      Icons.login,
                      color: Theme.of(context).primaryColor,
                      size: 80,
                    ),
                    16.height(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push(AuthLoginPage.path, extra: false);
                        },
                        child: Text(context.translation.logIn),
                      ),
                    ),
                  ],
                ),
              ),
              32.height(),
              ConsumerWidget(
                cubit: cubit,
                loadingBuilder: (context) => const SizedBox.shrink(),
                childBuilder: (context, state) {
                  return Column(
                    children: [
                      HeaderText(
                        title: context.translation.callMaisonHub,
                        textStyle: Theme.of(context).textTheme.headlineSmall,
                      ),
                      16.height(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          children: [
                            for (var e in ContactType.values) ...[
                              for (var k in state.where((j) => j.type == e)) ...[
                                ContactUsCard(contactItem: k),
                              ],
                            ],
                          ],
                        ),
                      ),
                      120.height(),
                    ],
                  );
                },
                autoDispose: false,
                onRetry: () {
                  cubit.start();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
