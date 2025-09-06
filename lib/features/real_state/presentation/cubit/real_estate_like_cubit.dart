// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';
// import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
// import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
// import 'package:real_state/features/real_state/domain/repository/real_estate_repository.dart';
//
// @injectable
// class RealEstateLikeCubit extends Cubit<BaseState<bool>> {
//   RealEstateRepository repository;
//
//   RealEstateLikeCubit(this.repository) : super(BaseState());
//
//   void init(RealEstate r) {
//     emit(state.setSuccessState(r.isFavourite));
//   }
//
//   void like(String id) async {
//     emit(state.setInProgressState());
//     var res = await repository.save(id: id);
//     res.fold(
//       (e) => emit(state.setFailureState(e)),
//       (r) => emit(state.setSuccessState(true)),
//     );
//   }
//
//   void unLike(String id) async {
//     emit(state.setInProgressState());
//     var res = await repository.unSave(id: id);
//     res.fold(
//       (e) => emit(state.setFailureState(e)),
//       (r) => emit(state.setSuccessState(true)),
//     );
//   }
// }
