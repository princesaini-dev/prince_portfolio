abstract class ThemeBlocEvent {}

class ThemeEventLight extends ThemeBlocEvent {
  final bool isLightTheme;
  ThemeEventLight({required this.isLightTheme});
}
