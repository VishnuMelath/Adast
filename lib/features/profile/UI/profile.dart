

import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/custom_widgets/customtile.dart';
import 'package:adast/features/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                //todo settings icon button pressed
              },
              icon: const Icon(
                Icons.settings,
                color: green,
              ))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: BlocBuilder<BottomNavBloc, BottomNavState>(
              builder: (context, state) {
              final user = context.read<BottomNavBloc>().userModel;
                if (state.runtimeType == BottomNavUserLoadingState) {
                  return Card(
                      child: ListTile(
                    leading: Lottie.asset('assets/lottie/square.json',
                        fit: BoxFit.fitHeight),
                    title: Lottie.asset('assets/lottie/3C6cGI7FQu (1).json',
                        fit: BoxFit.contain),
                    subtitle: Lottie.asset('assets/lottie/3C6cGI7FQu.json',
                        height: 20),
                  ));
                } else if (state.runtimeType ==
                    BottomNavUserLoadingSuccessState) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(
                          user!.image ??
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8A2wOvDj7sAobit1mD4lCc6ilEaBm_CF3AQ&s',
                          width: 50,
                          height: 50,
                        ),
                        title: Text(
                          user.name,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(user.email),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(
                    child: Text('error'),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  customListTile('Personal Details'),
                  customListTile('My Reservations'),
                  customListTile('Saved'),
                  customListTile('Settings')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
