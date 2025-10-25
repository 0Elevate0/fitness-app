import 'package:equatable/equatable.dart';
import 'package:fitness_app/presentation/home/views/home_view.dart';
import 'package:flutter/material.dart';

final class FitnessBottomNavigationState extends Equatable {
  final List<Widget> taps = const [
    HomeView(),
    Center(
      child: Text(
        "Chat Screen",
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        "Workouts Screen",
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        "Profile Screen",
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    ),
  ];
  final int currentIndex;
  const FitnessBottomNavigationState({this.currentIndex = 0});
  FitnessBottomNavigationState copyWith({int? currentIndex}) {
    return FitnessBottomNavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [currentIndex];
}
