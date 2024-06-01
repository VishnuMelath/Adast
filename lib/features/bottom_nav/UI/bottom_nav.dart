import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/features/profile/UI/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bottom_nav_bloc.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  BottomNavBloc bottomNavBloc=BottomNavBloc();

  int selectedIndex = 0;
  List<Widget> pages = List.generate(
    3,
    (index) => Center(
      child: Text((index + 1).toString()),
    ),
  );
  @override
  void initState() {
    bottomNavBloc.add(BottomNavInitialEvent());
    pages.add(const Profile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavBloc>(
      create: (context) => bottomNavBloc,
      child: Scaffold(
          body: pages[selectedIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BottomNavigationBar(
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: green,
                    unselectedItemColor: grey,
                    currentIndex: selectedIndex,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home_filled), label: 'home'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.search), label: 'search'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.map_outlined), label: 'map'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person), label: 'person')
                    ]),
              ),
            ),
          )),
    );
  }
}
