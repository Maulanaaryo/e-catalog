part of 'products_bloc.dart';

sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final List<ProductsResponseModel> data;

  ProductsLoaded({required this.data});
}

final class ProductsError extends ProductsState {
  final String message;

  ProductsError({required this.message});
}