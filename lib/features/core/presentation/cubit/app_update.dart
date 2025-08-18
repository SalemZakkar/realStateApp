import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/domain/entity/app_state.dart';
import 'package:real_state/features/core/domain/repository/core_repository.dart';

@singleton
class AppUpdateCubit extends Cubit<AppUpdateState> {
  AppUpdateCubit(this.coreRepository) : super(NormalAppState());

  CoreRepository coreRepository;

  void init() {
    coreRepository.appStatus.listen((e) {
      emit(e);
    });
  }
}
