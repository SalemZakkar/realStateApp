import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';

@singleton
class RealEstateDetailsCubit extends Cubit<BaseState<RealEstate>> {
  RealEstateDetailsCubit() : super(BaseState());

  void run(RealEstate data) {
    emit(state.setSuccessState(data));
  }
}
