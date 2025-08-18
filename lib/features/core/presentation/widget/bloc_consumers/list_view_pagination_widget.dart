import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/core/presentation/cubit/pagination_cubit.dart';

import '../../../../../generated/translation/translations.dart';
import '../../../domain/entity/paginated_params.dart';
import '../../cubit/base_states/base_paginated_list_state.dart';
import 'error_view.dart';
import 'loader.dart';

class ListViewPaginationWidget<T> extends StatefulWidget {
  final PaginationCubit paginationCubit;
  final PaginationParams? params;
  final Widget Function(T) itemBuilder;
  final Widget? emptyState;
  final Axis scrollDirection;
  final double height;
  final bool withRefreshIndicator;
  final Function(PaginationParams)? onParamsChanged;
  final Function(bool)? onReversScroll;
  final bool autoDispose;
  final bool shrinkWrap;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsets? padding;
  final Widget? loader;
  final Widget Function(Widget)? errorBuilder;
  final Widget? noDataWidget;

  const ListViewPaginationWidget({
    super.key,
    required this.paginationCubit,
    this.params,
    required this.itemBuilder,
    this.emptyState,
    this.scrollDirection = Axis.vertical,
    this.height = 100.0,
    this.withRefreshIndicator = true,
    this.onParamsChanged,
    this.onReversScroll,
    this.autoDispose = true,
    this.shrinkWrap = true,
    this.scrollController,
    this.scrollPhysics,
    this.padding,
    this.loader,
    this.errorBuilder,
    this.noDataWidget,
  });

  @override
  State<ListViewPaginationWidget<T>> createState() =>
      _ListViewPaginationWidgetState<T>();
}

class _ListViewPaginationWidgetState<T>
    extends State<ListViewPaginationWidget<T>> {
  late ScrollController scrollController;
  bool autoScrollLock = false;

  @override
  void initState() {
    scrollController = widget.scrollController ?? ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          !widget.paginationCubit.state.isInProgress &&
          !widget.paginationCubit.state.hasReachedMax) {
        widget.paginationCubit.paginate();
      }
    });
    if (widget.paginationCubit.state.items.isEmpty &&
        !widget.paginationCubit.state.isInProgress) {
      widget.paginationCubit.get(params: widget.params);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.scrollController == null) {
      scrollController.dispose();
    }
    if (widget.autoDispose) {
      widget.paginationCubit.close();
    }
  }

  // @override
  // void didUpdateWidget(ListViewPaginationWidget<T> oldWidget) {
  //   if (widget.params != null) {
  //     if (widget.params != oldWidget.params) {
  //       widget.paginationCubit.get(
  //         params: widget.params,
  //       );
  //     }
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  void jumpToLast() {
    if (autoScrollLock) {
      return;
    }
    autoScrollLock = true;
    scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.paginationCubit.get(params: widget.params);
      },
      notificationPredicate: (_) => widget.withRefreshIndicator,
      child: BlocConsumer<PaginationCubit, BasePaginatedListState>(
        bloc: widget.paginationCubit,
        listener: (context, state) {
          /// to scroll to loading
          if (state.isPaginateInProgress) {
            jumpToLast();
          }
          if (!state.isPaginateInProgress) {
            autoScrollLock = false;
          }
        },
        builder: (context, state) {
          if ((state.isInProgress)) {
            return widget.loader ??
                const _FillRemainingScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Loader(),
                  ),
                );
          } else if ((state.isFailure)) {
            Widget error = Center(
              child: ErrorView(
                failure: state.failure,
                onRetry: () =>
                    widget.paginationCubit.get(params: widget.params),
              ),
            );
            return widget.errorBuilder?.call(error) ??
                _FillRemainingScrollView(child: error);
          }
          if (state.items.isEmpty) {
            return widget.noDataWidget ??
                _FillRemainingScrollView(
                  child: Center(
                    child:
                        widget.emptyState ??
                        Text(Translations.of(context)!.noData),
                  ),
                );
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is UserScrollNotification) {
                if (widget.onReversScroll != null) {
                  if (notification.direction == ScrollDirection.reverse) {
                    widget.onReversScroll!(true);
                  } else if (notification.direction ==
                      ScrollDirection.forward) {
                    widget.onReversScroll!(false);
                  }
                }

                if (((notification.direction == ScrollDirection.reverse) ||
                        (notification.direction == ScrollDirection.idle)) &&
                    state.isSuccess) {
                  double maxScroll = notification.metrics.maxScrollExtent;
                  double currentScroll = notification.metrics.pixels;
                  double delta = 150.0;
                  if (maxScroll - currentScroll <= delta) {
                    if (!widget.paginationCubit.state.hasReachedMax) {
                      widget.paginationCubit.paginate();
                    }
                  }
                }
              }

              return false;
            },
            child: SizedBox(
              height: widget.scrollDirection == Axis.vertical
                  ? null
                  : widget.height.toDouble(),
              child: CustomScrollView(
                shrinkWrap: widget.shrinkWrap,
                physics: widget.scrollPhysics,
                scrollDirection: widget.scrollDirection,
                // controller: scrollController,
                controller: widget.scrollController != null
                    ? null
                    : scrollController,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((_, int index) {
                      bool hasOneItem = state.items.length == 1;
                      bool hasTwoItems = state.items.length == 2;
                      bool isFirstItem = index == 0;
                      bool isLastItem = index == state.items.length - 1;
                      return Padding(
                        padding: widget.scrollDirection == Axis.vertical
                            ? EdgeInsets.zero
                            : hasOneItem
                            ? const EdgeInsets.symmetric(horizontal: 16)
                            : hasTwoItems
                            ? isFirstItem
                                  ? const EdgeInsetsDirectional.only(
                                      start: 16,
                                      end: 8,
                                    )
                                  : const EdgeInsetsDirectional.only(end: 16)
                            //Otherwise (List include more than 2 items)
                            : isFirstItem
                            ? const EdgeInsetsDirectional.only(
                                start: 16,
                                end: 4,
                              )
                            : isLastItem
                            ? const EdgeInsetsDirectional.only(end: 16)
                            : const EdgeInsets.symmetric(horizontal: 4),
                        child: widget.itemBuilder(state.items[index]),
                      );
                    }, childCount: state.items.length),
                  ),
                  if (state.isPaginateInProgress)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Loader(),
                      ),
                    ),
                  if (state.isPaginateFailure)
                    SliverToBoxAdapter(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(8),
                        child: ErrorView(
                          failure: state.failure,
                          onRetry: () {
                            widget.paginationCubit.paginate();
                          },
                        ),
                      ),
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FillRemainingScrollView extends StatelessWidget {
  const _FillRemainingScrollView({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: constraints.maxHeight,
            maxWidth: constraints.maxWidth,
          ),
          child: child,
        ),
      ),
    );
  }
}
