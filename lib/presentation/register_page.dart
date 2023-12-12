import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/bloc/register/register_bloc.dart';
import 'package:flutter_ecatalog/data/models/request/register_request_model.dart';
import 'package:flutter_ecatalog/presentation/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController!.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Register Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              controller: nameController,
            ),
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
            BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                if (state is RegisterLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Register Success with ID ${state.model.id}'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                }
              },
              builder: (context, state) {
                if (state is RegisterLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    final registerModel = RegisterRequestModel(
                      name: nameController!.text,
                      email: emailController!.text,
                      password: passwordController!.text,
                    );

                    context.read<RegisterBloc>().add(
                          DoRegisterEvent(model: registerModel),
                        );
                  },
                  child: const Text('REGISTER'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
