import 'package:fitness_app/presentation/home/views/widgets/chat_ai_screen.dart';
import 'package:fitness_app/presentation/home/views/widgets/explore_screen.dart';
import 'package:fitness_app/presentation/home/views/widgets/profile_screen.dart';
import 'package:fitness_app/presentation/home/views/widgets/workout_screen.dart';
import 'package:fitness_app/utils/common_widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    ExploreScreen(),
    ChatAiScreen(),
    WorkoutScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
