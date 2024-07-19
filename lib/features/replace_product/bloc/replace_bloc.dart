import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'replace_event.dart';
part 'replace_state.dart';

class ReplaceBloc extends Bloc<ReplaceEvent, ReplaceState> {
  ReplaceBloc() : super(ReplaceInitial()) {
    on<ReplaceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
