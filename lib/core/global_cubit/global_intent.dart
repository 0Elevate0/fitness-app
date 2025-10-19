import 'package:fitness_app/core/global_cubit/global_state.dart';

sealed class GlobalIntent {}

class GlobalInitializationIntent extends GlobalIntent {}

class ChangeLanguageIntent extends GlobalIntent {
  ChangeLanguageIntent({required this.newSelectedLanguage});
  final Language newSelectedLanguage;
}
