import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_ecatalog/data/models/request/product_request_model.dart';
import 'package:flutter_ecatalog/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductsDataSource {
  Future<Either<String, List<ProductsResponseModel>>> getAllProduct() async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products/'),
    );

    if (response.statusCode == 200) {
      return Right(List.from(jsonDecode(response.body)
          .map((x) => ProductsResponseModel.fromMap(x))));
    } else {
      return const Left('get product error');
    }
  }

  Future<Either<String, List<ProductsResponseModel>>> getPaginationProduct(
      {required int offset, required int limit}) async {
    final response = await http.get(
      Uri.parse(
          'https://api.escuelajs.co/api/v1/products/?offset=$offset&limit=$limit'),
    );

    if (response.statusCode == 200) {
      return Right(List.from(jsonDecode(response.body)
          .map((x) => ProductsResponseModel.fromMap(x))));
    } else {
      return const Left('get product error');
    }
  }

  Future<Either<String, ProductsResponseModel>> createProduct(
      ProductsRequestModel model) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/products/'),
      body: model.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return Right(ProductsResponseModel.fromJson(response.body));
    } else {
      return const Left('failed add product');
    }
  }
}
