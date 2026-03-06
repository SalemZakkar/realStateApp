import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/properties/presentation/cubits/properties_details_cubit.dart';
import 'package:real_state/features/properties/presentation/cubits/property_file_cubit.dart';
import 'package:real_state/injection.dart';
import 'package:real_state/themes/app_theme.dart';

class PropertyManageImagePage extends StatefulWidget {
  static String path = "/PropertiesManageImagePage";
  final String id;

  const PropertyManageImagePage({super.key, required this.id});

  @override
  State<PropertyManageImagePage> createState() =>
      _PropertyManageImagePageState();
}

class _PropertyManageImagePageState extends State<PropertyManageImagePage> {
  var cubit = getIt<PropertyFileCubit>();
  var getById = getIt<PropertiesDetailsCubit>();

  @override
  void initState() {
    super.initState();
    getById.get(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.images)),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        // height: 60,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8
        ),
        color: Theme.of(context).cardColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: context.pop,
                child: Text(context.translation.done),
              ),
            ),
          ],
        ),
      ),
      body: ScreenLoader(
        cubit: cubit,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          constraints: const BoxConstraints.expand(),
          child: ConsumerWidget(
            cubit: getById,
            childBuilder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CustomCardWidget(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(context.translation.youCanAddUpTo6Images),
                      ),
                    ),
                    16.height(),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        mainAxisExtent: 250,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        if (index < state.images.length) {
                          return _Image(
                            id: state.images[index],
                            onDelete: () {
                              cubit.deleteImage(widget.id, state.images[index]);
                            },
                          );
                        }
                        if (state.images.length < 6) {
                          return InkWellWithoutFeedback(
                            onTap: () async {
                              var res = await FilePickUtil.getImage(
                                source: ImageSource.gallery,
                                quality: 40,
                              );
                              if (res != null) {
                                cubit.addImage(widget.id, res);
                              }
                            },
                            child: CustomCardWidget(
                              child: Center(
                                child: Text(
                                  context.translation.chooseImageToAddIt,
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      itemCount: state.images.length + 1,
                    ),
                  ],
                ),
              );
            },
            onRetry: () => getById.get(widget.id),
          ),
        ),
      ),
    );
  }
}

class _Image extends StatefulWidget {
  final String id;
  final VoidCallback onDelete;

  const _Image({super.key, required this.id, required this.onDelete});

  @override
  State<_Image> createState() => _ImageState();
}

class _ImageState extends State<_Image> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageWidget(
          width: double.infinity,
          height: double.infinity,
          url: widget.id.getUrl,
          borderRadius: BorderRadius.circular(12),
        ),
        PositionedDirectional(
          top: 8,
          start: 8,
          child: InkWellWithoutFeedback(
            onTap: () {
              widget.onDelete();
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.delete,
                color: context.appColorSchema.statusColors.fail,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
