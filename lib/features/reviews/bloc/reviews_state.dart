part of 'reviews_bloc.dart';

@immutable
sealed class ReviewsState {}

final class ReviewsInitial extends ReviewsState {}

class ReviewsLoadedState extends ReviewsState{}

class ReviewsLoadingState extends ReviewsState{}