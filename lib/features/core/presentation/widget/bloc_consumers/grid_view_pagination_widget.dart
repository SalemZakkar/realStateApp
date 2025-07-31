// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pharmacy_ca_mobile/core/presentation/blocs/base_states/base_paginated_list_state.dart';
// import 'package:pharmacy_ca_mobile/core/presentation/blocs/cubits/pagination_cubit/pagination_cubit.dart';
// import 'package:pharmacy_ca_mobile/core/presentation/blocs/cubits/pagination_cubit/pagination_cubit_params.dart';
// import 'package:pharmacy_ca_mobile/core/presentation/utils/generated/translation/translations.dart';
// import 'package:pharmacy_ca_mobile/core/presentation/widgets/bloc_consumers/error_view.dart';
// import 'package:pharmacy_ca_mobile/core/presentation/widgets/bloc_consumers/loader.dart';
//
// class GridViewPaginationWidget<T> extends StatefulWidget {
//   final PaginationCubit paginationCubit;
//   final PaginationParams? params;
//   final Widget Function(T) itemBuilder;
//   final Widget? emptyState;
//   final Axis scrollDirection;
//   final double height;
//   final bool withRefreshIndicator;
//   final Function(PaginationParams)? onParamsChanged;
//   final Function(bool)? onReversScroll;
//   final SliverGridDelegate delegate;
//   final ScrollController? controller;
//   final bool shrinkWrap;
//
//   const GridViewPaginationWidget({
//     super.key,
//     required this.paginationCubit,
//     this.params,
//     required this.itemBuilder,
//     this.emptyState,
//     this.scrollDirection = Axis.vertical,
//     this.height = 100.0,
//     this.withRefreshIndicator = true,
//     this.onParamsChanged,
//     this.onReversScroll,
//     required this.delegate,
//     this.controller,
//     this.shrinkWrap = false,
//   });
//
//   @override
//   State<GridViewPaginationWidget<T>> createState() =>
//       _GridViewPaginationWidgetState<T>();
// }
//
// class _GridViewPaginationWidgetState<T>
//     extends State<GridViewPaginationWidget<T>> {
//   late ScrollController scrollController;
//   bool autoScrollLock = false;
//
//   @override
//   void initState() {
//     if (widget.paginationCubit.state.items.isEmpty &&
//         !widget.paginationCubit.state.isInProgress) {
//       widget.paginationCubit.get(params: widget.params);
//     }
//     scrollController = widget.controller ?? ScrollController();
//     scrollController.addListener(() {
//       if ((scrollController.offset ==
//               scrollController.position.maxScrollExtent) &&
//           !widget.paginationCubit.state.isInProgress &&
//           !widget.paginationCubit.state.hasReachedMax) {
//         widget.paginationCubit.paginate();
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     scrollController.dispose();
//   }
//
//   @override
//   void didUpdateWidget(GridViewPaginationWidget<T> oldWidget) {
//     if (widget.params != null) {
//       if (widget.params != oldWidget.params) {
//         widget.paginationCubit.get(
//           params: widget.params,
//         );
//       }
//     }
//     super.didUpdateWidget(oldWidget);
//   }
//
//   void jumpToLast() {
//     if (autoScrollLock) {
//       return;
//     }
//     autoScrollLock = true;
//     scrollController.jumpTo(scrollController.position.maxScrollExtent + 50);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         widget.paginationCubit.get(
//           params: widget.params,
//         );
//       },
//       child: BlocConsumer<PaginationCubit, BasePaginatedListState>(
//         bloc: widget.paginationCubit,
//         listener: (context, state) {
//           if (state.isSuccess) {
//             WidgetsBinding.instance.addPostFrameCallback((e) {
//               try {
//                 if ((scrollController.offset ==
//                         scrollController.position.maxScrollExtent) &&
//                     !widget.paginationCubit.state.isInProgress &&
//                     !widget.paginationCubit.state.hasReachedMax) {
//                   widget.paginationCubit.paginate();
//                 }
//               } catch (e) {
//                 debugPrint("EMPTY DATA");
//               }
//             });
//           }
//           if (state.isPaginateInProgress) {
//             // jumpToLast();
//           }
//           if (!state.isPaginateInProgress) {
//             autoScrollLock = false;
//           }
//         },
//         builder: (context, state) {
//           if ((state.isInProgress)) {
//             return const _FillRemainingScrollView(
//               child: Padding(
//                 padding: EdgeInsets.only(top: 16),
//                 child: Loader(),
//               ),
//             );
//           } else if ((state.isFailure)) {
//             return _FillRemainingScrollView(
//               child: Center(
//                 child: ErrorView(
//                   failure: state.failure,
//                   onRetry: () =>
//                       widget.paginationCubit.get(params: widget.params),
//                 ),
//               ),
//             );
//           }
//           if (state.items.isEmpty) {
//             return _FillRemainingScrollView(
//               child: Center(
//                 child:
//                     widget.emptyState ?? Text(Translations.of(context)!.noData),
//               ),
//             );
//           }
//           return GridView.builder(
//             shrinkWrap: widget.shrinkWrap,
//             padding: EdgeInsets.symmetric(vertical: 8),
//             physics:
//                 widget.shrinkWrap ? const NeverScrollableScrollPhysics() : null,
//             controller: widget.controller == null ? scrollController : null,
//             gridDelegate: widget.delegate,
//             itemBuilder: (context, index) {
//               if (index < state.items.length) {
//                 return widget.itemBuilder(state.items[index]);
//               }
//               if (state.isPaginateInProgress) {
//                 return SizedBox(
//                   child: Center(
//                     child: Loader(),
//                   ),
//                 );
//               }
//               if (state.isPaginateFailure) {
//                 return SizedBox(
//                   child: Center(
//                     child: ErrorView(
//                       onRetry: () {
//                         widget.paginationCubit.paginate();
//                       },
//                       failure: state.failure,
//                     ),
//                   ),
//                 );
//               }
//               return const SizedBox();
//             },
//             itemCount: state.items.length + (!state.isSuccess ? 1 : 0),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class _FillRemainingScrollView extends StatelessWidget {
//   const _FillRemainingScrollView({required this.child});
//
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) => SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxHeight: constraints.maxHeight,
//             maxWidth: constraints.maxWidth,
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
// }
