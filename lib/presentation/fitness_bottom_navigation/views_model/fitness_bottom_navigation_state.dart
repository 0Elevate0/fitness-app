import 'package:equatable/equatable.dart';

class FitnessBottomNavigationState extends Equatable {
  final int selectedIndex;

  const FitnessBottomNavigationState({required this.selectedIndex});

  FitnessBottomNavigationState copyWith({int? selectedIndex}) {
    return FitnessBottomNavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object> get props => [selectedIndex];
}
