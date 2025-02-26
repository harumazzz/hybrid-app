part of 'language_cubit.dart';

@immutable
sealed class LanguageState extends Equatable {
  final String value;

  const LanguageState({
    required this.value,
  });

  @override
  List<Object?> get props => [value];
}

final class LanguageInitial extends LanguageState {
  const LanguageInitial() : super(value: 'en');
}

final class LanguageChange extends LanguageState {
  const LanguageChange({
    required super.value,
  });
}
