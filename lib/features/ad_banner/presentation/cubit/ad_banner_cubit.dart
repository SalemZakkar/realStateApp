import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/ad_banner/domain/entity/ad_banner.dart';
import 'package:real_state/features/ad_banner/domain/repository/ad_banner_repository.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';

@singleton
class AdBannerCubit extends Cubit<BaseState<List<AdBanner>>> {
  AdBannerCubit(this.repository) : super(BaseState());
  AdBannerRepository repository;

  void get() async {
    if (state.isSuccess) {
      emit(state);
      return;
    }
    emit(state.setInProgressState());
    var res = await repository.getAdBanner();
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
