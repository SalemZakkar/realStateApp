import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_state/features/core/presentation/page/view_image_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/utils/file_manager.dart';
import 'package:real_state/features/core/presentation/utils/file_pick.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/screen_loader.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/custom_card_widget.dart';
import 'package:real_state/features/core/presentation/widget/image_widget.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_params.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_add_image_cubit.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_delete_image_cubit.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/injection.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class RealEstateImageManageWidget extends StatefulWidget {
  final RealEstate realEstate;
  final ValueChanged<List<String>> imageChanged;

  const RealEstateImageManageWidget({
    super.key,
    required this.realEstate,
    required this.imageChanged,
  });

  @override
  State<RealEstateImageManageWidget> createState() =>
      _RealEstateImageManageWidgetState();
}

class _RealEstateImageManageWidgetState
    extends State<RealEstateImageManageWidget> {
  late RealEstateParams params;

  var addCubit = getIt<RealEstateAddImageCubit>();
  var delCubit = getIt<RealEstateDeleteImageCubit>();

  @override
  void initState() {
    super.initState();
    params = RealEstateParams(
      id: widget.realEstate.id,
      images: widget.realEstate.images,
    );
    params.images ??= [];
  }

  String? id;

  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      withSuccess: false,
      cubit: delCubit,
      autoDispose: false,
      onSuccess: (v) {
        params.images!.remove(id);
        widget.imageChanged(params.images!);
        setState(() {});
      },
      child: ScreenLoader(
        withSuccess: false,
        cubit: addCubit,
        autoDispose: false,
        onSuccess: (v) {
          params.images!.add(v.images.last);
          widget.imageChanged(params.images!);

          setState(() {});
        },
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (params.images!.isNotEmpty) ...[
                  CustomCardWidget(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        context.translation.longPressOnTheImageAndDragIt,
                      ),
                    ),
                  ),
                  16.height(),
                ],
                ReorderableGridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index >= params.images!.length) {
                      return InkWellWithoutFeedback(
                        key: Key("+"),
                        onTap: () async {
                          var k = await FilePickUtil.getImage(
                            source: ImageSource.gallery,
                          );
                          if (k != null) {
                            addCubit.add(file: k, id: widget.realEstate.id);
                          }
                        },
                        child: CustomCardWidget(child: Icon(Icons.add)),
                      );
                    }
                    return _Card(
                      url: params.images![index],
                      realEstateId: params.id!,
                      addImageCubit: addCubit,
                      deleteImageCubit: delCubit,
                      key: Key(index.toString()),
                      onDelete: (v) {
                        id = v;
                        params.images!.remove(v);
                        setState(() {});
                      },
                      onAdd: (v) {
                        params.images!.add(v);
                        setState(() {});
                      },
                    );
                  },
                  itemCount: params.images!.length + 1,

                  onReorder: (old, n) {
                    if (old >= widget.realEstate.images.length ||
                        n >= widget.realEstate.images.length) {
                      return;
                    }
                    var t = params.images![old];
                    params.images![old] = params.images![n];
                    params.images![n] = t;
                    setState(() {});
                  },

                  dragStartDelay: Duration(milliseconds: 180),
                  // physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisExtent: 300,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Card extends StatefulWidget {
  const _Card({
    super.key,
    required this.url,
    required this.onDelete,
    required this.onAdd,
    required this.realEstateId,
    required this.addImageCubit,
    required this.deleteImageCubit,
  });

  final ValueChanged<String> onAdd, onDelete;
  final String url;
  final String realEstateId;

  final RealEstateDeleteImageCubit deleteImageCubit;
  final RealEstateAddImageCubit addImageCubit;

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          ImageWidget(
            url: getIt<FileManager>().getFile(name: widget.url),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          PositionedDirectional(
            top: 8,
            end: 8,
            child: InkWellWithoutFeedback(
              onTap: () {
                widget.onDelete(widget.url);
                widget.deleteImageCubit.delete(id: widget.url);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  shape: BoxShape.circle,
                ),

                child: Assets.icons.delete.dynamicSVGColor(context),
              ),
            ),
          ),
          PositionedDirectional(
            top: 8,
            start: 8,
            child: InkWellWithoutFeedback(
              onTap: () {
                context.pushNamed(ViewImagePage.path, extra: widget.url);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  shape: BoxShape.circle,
                ),
                child: Assets.icons.expand.dynamicSVGColor(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
