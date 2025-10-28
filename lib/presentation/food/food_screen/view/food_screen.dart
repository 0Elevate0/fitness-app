import 'package:fitness_app/core/router/route_names.dart';
import 'package:flutter/material.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealId = "52959";

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              RouteNames.foodDetails,
              arguments: mealId,
            );
          },
          child: const Text("To food details"),
        ),
      ),
    );
  }
}
