part of 'add_product_bloc.dart';

sealed class AddProductState {}

final class AddProductInitial extends AddProductState {}

final class AddProductLoading extends AddProductState {}

final class AddProductLoaded extends AddProductState {
  final ProductsResponseModel model;

  AddProductLoaded({required this.model});
}

final class AddProductError extends AddProductState {
  final String message;

  AddProductError({required this.message});
}
