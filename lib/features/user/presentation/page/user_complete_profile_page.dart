import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/user_builder.dart';
import 'package:real_state/features/core/presentation/widget/button/log_out_button.dart';
import 'package:real_state/features/user/domain/params/user_update_params.dart';
import 'package:real_state/features/user/presentation/cubit/user_update_cubit.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/injection.dart';

class UserCompleteProfilePage extends StatefulWidget {
  static String path = "/UserCompleteProfilePage";

  const UserCompleteProfilePage({super.key});

  @override
  State<UserCompleteProfilePage> createState() =>
      _UserCompleteProfilePageState();
}

class _UserCompleteProfilePageState extends State<UserCompleteProfilePage> {
  var cubit = getIt<UserUpdateCubit>();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FormFieldWidget(
      builder: (k) => Scaffold(
        appBar: AppBar(),
        body: ScreenLoader(
          cubit: cubit,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            constraints: const BoxConstraints.expand(),
            child: UserBuilder(
              onInit: (v) {
                controller.text = v.name ?? '';
              },
              builder: (context, user) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      16.height(),
                      ImageWidget(
                        radius: 150,
                        shape: BoxShape.circle,
                        editable: true,
                        url: user.image?.getUrl,
                        placeHolder: Assets.images.profilePlaceholder.image(
                          width: 200,
                          // fit: BoxFit.cover,
                        ),
                        pickImageConfig: PickImageConfig(withCrop: false),
                        onChanged: (v) {
                          cubit.change(UserUpdateParams(image: v));
                        },
                      ),
                      32.height(),
                      TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: context.translation.name,
                        ),
                        validator: RequiredValidator(
                          errorText: context.translation.fieldRequiredMessage,
                        ).call,
                      ),
                      16.height(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!k.currentState!.validate()) {
                              return;
                            }
                            cubit.complete(
                              UserUpdateParams(name: controller.text.valOrNull),
                            );
                          },
                          child: Text(context.translation.continuE),
                        ),
                      ),
                      8.height(),
                      LogOutButton(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
