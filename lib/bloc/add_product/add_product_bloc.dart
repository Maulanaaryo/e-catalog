import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/data/models/request/product_request_model.dart';

import 'package:flutter_ecatalog/data/datasources/products_datasource.dart';
import 'package:flutter_ecatalog/data/models/response/product_response_model.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductsDataSource dataSource;
  AddProductBloc(
    this.dataSource,
  ) : super(AddProductInitial()) {
    on<DoAddProductEvent>((event, emit) async {
      emit(AddProductLoading());
      final result = await dataSource.createProduct(event.data);
      result.fold((error) => emit(AddProductError(message: error)),
          (data) => emit(AddProductLoaded(model: data)));
    });
  }
}
