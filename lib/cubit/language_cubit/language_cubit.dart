import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial()) {
    _onLoad();
  }

  void _onLoad() async {
    final instance = await SharedPreferences.getInstance();
    final language = instance.getString('lang');
    emit(LanguageChange(value: language ?? 'en'));
  }

  Future<void> changeLangugage(
    String value,
  ) async {
    emit(LanguageChange(value: value));
    final instance = await SharedPreferences.getInstance();
    await instance.setString('lang', value);
  }
}
