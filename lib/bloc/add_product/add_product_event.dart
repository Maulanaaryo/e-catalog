part of 'add_product_bloc.dart';

sealed class AddProductEvent {}

class DoAddProductEvent extends AddProductEvent {
  final ProductsRequestModel data;

  DoAddProductEvent({required this.data});
}
