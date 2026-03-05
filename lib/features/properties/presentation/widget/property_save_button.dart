import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:real_state/features/auth/presentation/page/auth_login_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/dialogs/dialog_util.dart';
import 'package:real_state/features/properties/domain/repository/property_repository.dart';
import 'package:real_state/injection.dart';

class PropertySaveButton extends StatefulWidget {
  final String property;
  final bool isSaved;

  const PropertySaveButton({
    super.key,
    required this.property,
    required this.isSaved,
  });

  @override
  State<PropertySaveButton> createState() => _PropertySaveButtonState();
}

class _PropertySaveButtonState extends State<PropertySaveButton> {
  @override
  Widget build(BuildContext context) {
    return InkWellWithoutFeedback(
      onTap: () {
        if (!getIt<AuthCubit>().state.authenticated) {
          DialogUtil(
            context: context,
            onAccept: () {
              context.push(AuthLoginPage.path, extra: false);
            },
          ).showConfirmDialog(
            message: context.translation.youNeedToLoginFirst,
            title: context.translation.logIn,
          );
          return;
        }
        if (widget.isSaved) {
          getIt<PropertiesRepository>().unSave(widget.property);
          // widget.property.isSaved = false;
        } else {
          getIt<PropertiesRepository>().save(widget.property);
          // widget.property.isSaved = true;
        }
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).cardColor,
        ),
        child: widget.isSaved
            ? Icon(Icons.bookmark_added)
            : Icon(Icons.bookmark_add_outlined),
      ),
    );
  }
}
