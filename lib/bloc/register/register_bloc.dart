import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/data/datasources/auth_datasource.dart';
import 'package:flutter_ecatalog/data/models/request/register_request_model.dart';
import 'package:flutter_ecatalog/data/models/response/register_respon_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDataSource authDataSource;
  RegisterBloc(this.authDataSource) : super(RegisterInitial()) {
    on<DoRegisterEvent>((event, emit) async {
      emit(RegisterLoading());

      // send register request model to datasource
      final result = await authDataSource.register(event.model);
      result.fold(
        (error) => emit(
          RegisterError(message: error),
        ),
        (data) => emit(
          RegisterLoaded(model: data),
        ),
      );
    });
  }
}
