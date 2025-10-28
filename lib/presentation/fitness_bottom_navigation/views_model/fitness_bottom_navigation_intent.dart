import 'package:flutter/material.dart';

sealed class FitnessBottomNavigationIntent {
  const FitnessBottomNavigationIntent();
}

final class ChangeIndexIntent extends FitnessBottomNavigationIntent {
  final int index;
  final Widget? changedTap;

  const ChangeIndexIntent({required this.index, this.changedTap});
}
