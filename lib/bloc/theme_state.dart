part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {
  final isDark;
  ThemeState({required this.isDark});
}

class ThemeUpdated extends ThemeState {
  ThemeUpdated({required bool isDark}) : super(isDark: isDark);
}
