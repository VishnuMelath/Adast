import 'package:adast/features/reservations/UI/widgets/filter_box.dart';
import 'package:adast/features/reservations/bloc/reservations_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget filterReservationsWidget(
    BuildContext context, ReservationsBloc reservationsBloc) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, left: 10, bottom: 3),
    child: BlocBuilder<ReservationsBloc, ReservationsState>(
      bloc: reservationsBloc,
      builder: (context, state) {
        String selected=reservationsBloc.filter;
        return Wrap(
          spacing: 10,
          children: [
            filterBox(selected: selected, value: 'All',reservationsBloc: reservationsBloc),
            filterBox(selected: selected, value: 'Pending',reservationsBloc: reservationsBloc),
            filterBox(selected: selected, value: 'Failed',reservationsBloc: reservationsBloc),
            filterBox(selected: selected, value: 'Completed',reservationsBloc: reservationsBloc),
          ],
        );
      },
    ),
  );
}
