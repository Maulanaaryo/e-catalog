import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/bloc/add_product/add_product_bloc.dart';
import 'package:flutter_ecatalog/bloc/login/login_bloc.dart';
import 'package:flutter_ecatalog/bloc/products/products_bloc.dart';
import 'package:flutter_ecatalog/bloc/register/register_bloc.dart';
import 'package:flutter_ecatalog/data/datasources/auth_datasource.dart';
import 'package:flutter_ecatalog/data/datasources/products_datasource.dart';
import 'package:flutter_ecatalog/presentation/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(
            AuthDataSource(),
          ),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
            AuthDataSource(),
          ),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(
            ProductsDataSource(),
          ),
        ),
        BlocProvider(
          create: (context) => AddProductBloc(
            ProductsDataSource(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
