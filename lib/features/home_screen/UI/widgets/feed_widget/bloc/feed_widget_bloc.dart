import 'package:adast/services/seller_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'feed_widget_event.dart';
part 'feed_widget_state.dart';

class FeedWidgetBloc extends Bloc<FeedWidgetEvent, FeedWidgetState> {
  int currentPage=0;
  FeedWidgetBloc() : super(FeedWidgetInitial()) {
    on<FeedImageChangedEvent>((event, emit) {
      currentPage=event.page;
      emit(FeedImageChangedState());
    });
  }
}
