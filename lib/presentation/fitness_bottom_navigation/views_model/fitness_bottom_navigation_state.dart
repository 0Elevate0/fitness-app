import 'package:equatable/equatable.dart';
import 'package:fitness_app/presentation/home/views/home_view.dart';
import 'package:fitness_app/presentation/profile/views/profile_view.dart';
import 'package:fitness_app/presentation/work_out/views/work_out_view.dart';
import 'package:flutter/material.dart';

final class FitnessBottomNavigationState extends Equatable {
  final List<Widget> taps;
  final int currentIndex;

  const FitnessBottomNavigationState({
    this.currentIndex = 0,
    this.taps = const [
      HomeView(),
      Center(
        child: Text(
          "Chat Screen",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      WorkOutView(),
      ProfileView(),
    ],
  });

  FitnessBottomNavigationState copyWith({
    int? currentIndex,
    List<Widget>? taps,
  }) {
    return FitnessBottomNavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
      taps: taps ?? this.taps,
    );
  }

  @override
  List<Object?> get props => [currentIndex, taps];
}
