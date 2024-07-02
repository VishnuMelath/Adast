part of 'feed_widget_bloc.dart';

@immutable
sealed class FeedWidgetEvent {}

class FeedImageChangedEvent extends FeedWidgetEvent{
  final int page;

  FeedImageChangedEvent({required this.page});
}