import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/bloc/login/login_bloc.dart';
import 'package:flutter_ecatalog/data/datasources/local_datasource.dart';
import 'package:flutter_ecatalog/data/models/request/login_request_model.dart';
import 'package:flutter_ecatalog/presentation/home_page.dart';
import 'package:flutter_ecatalog/presentation/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    checkAuth();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  void checkAuth() async {
    final auth = await LocalDataSource().getToken();
    if (auth.isNotEmpty) {
      if (mounted) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              controller: emailController,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              controller: passwordController,
            ),
            const SizedBox(
              height: 16.0,
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                if (state is LoginLoaded) {
                  LocalDataSource().saveToken(state.model.accessToken);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login Success'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    final loginModel = LoginRequestModel(
                      email: emailController!.text,
                      password: passwordController!.text,
                    );

                    context.read<LoginBloc>().add(
                          DoLoginEvent(model: loginModel),
                        );
                  },
                  child: const Text('LOGIN'),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()));
              },
              child: const Text('REGISTER'),
            )
          ],
        ),
      ),
    );
  }
}
