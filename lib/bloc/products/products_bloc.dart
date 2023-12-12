import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/data/datasources/products_datasource.dart';
import 'package:flutter_ecatalog/data/models/response/product_response_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsDataSource dataSource;
  ProductsBloc(
    this.dataSource,
  ) : super(ProductsInitial()) {
    on<GetProductsEvent>((event, emit) async {
      emit(ProductsLoading());
      final result = await dataSource.getAllProduct();
      result.fold((error) => emit(ProductsError(message: error)),
          (data) => emit(ProductsLoaded(data: data)));
    });
  }
}
