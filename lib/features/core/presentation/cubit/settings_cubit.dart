import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

class SettingsState {
  String lang = 'en';

  SettingsState({this.lang = 'en'});
}

@singleton
class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(SettingsState());

  void setLang(String lang) {
    state.lang = lang;
    emit(state);
  }

  void set() {
    emit(state);
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState(lang: json['lang'] ?? 'en');
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return {"lang": state.lang};
  }
}
