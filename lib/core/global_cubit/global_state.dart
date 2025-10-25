import 'package:equatable/equatable.dart';

enum Language { arabic, english }

final class GlobalState extends Equatable {
  final bool isRedirectedScreenLoaded;
  final Language selectedLanguage;
  final String? redirectedScreen;
  const GlobalState({
    this.isRedirectedScreenLoaded = false,
    this.selectedLanguage = Language.english,
    this.redirectedScreen,
  });
  GlobalState copyWith({
    bool? isRedirectedScreenLoaded,
    Language? selectedLanguage,
    String? redirectedScreen,
  }) {
    return GlobalState(
      isRedirectedScreenLoaded:
          isRedirectedScreenLoaded ?? this.isRedirectedScreenLoaded,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      redirectedScreen: redirectedScreen ?? this.redirectedScreen,
    );
  }

  @override
  List<Object?> get props => [
    isRedirectedScreenLoaded,
    selectedLanguage,
    redirectedScreen,
  ];
}
