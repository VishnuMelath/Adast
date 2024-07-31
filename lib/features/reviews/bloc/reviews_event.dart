part of 'reviews_bloc.dart';

@immutable
sealed class ReviewsEvent {}

class ReviewsLoadingEvent extends ReviewsEvent{
  final String sellerId;

  ReviewsLoadingEvent({required this.sellerId});
}