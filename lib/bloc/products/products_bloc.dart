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
      final result =
          await dataSource.getPaginationProduct(offset: 0, limit: 10);
      result.fold((error) => emit(ProductsError(message: error)), (result) {
        bool isNext = result.length == 10;
        emit(ProductsLoaded(data: result, isNext: isNext));
      });
    });
    on<NextProductsEvent>((event, emit) async {
      final currestState = state as ProductsLoaded;
      final result = await dataSource.getPaginationProduct(
          offset: currestState.offset + 10, limit: 10);
      result.fold((error) => emit(ProductsError(message: error)), (result) {
        bool isNext = result.length == 10;
        emit(ProductsLoaded(
          data: [...currestState.data, ...result],
          offset: currestState.offset + 10,
          isNext: isNext,
        ));
      });
    });
  }
}
