part of 'feed_widget_bloc.dart';

@immutable
sealed class FeedWidgetState {}

final class FeedWidgetInitial extends FeedWidgetState {}

class FeedImageChangedState extends FeedWidgetState{}