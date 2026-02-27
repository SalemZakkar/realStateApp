import 'package:core_package/core_package.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/domain/entity/about_us.dart';
import 'package:real_state/features/core/domain/repository/core_repository.dart';

@lazySingleton
class AboutUsCubit extends Cubit<BaseState<AboutUs>> {
  AboutUsCubit(this.repository) : super(BaseState());
  CoreRepository repository;

  void start() async {
    if (state.isSuccess || state.isInProgress) {
      emit(state);
      return;
    }
    emit(state.setInProgressState());
    var res = await repository.getAboutUs();
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
