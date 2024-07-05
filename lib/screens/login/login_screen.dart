import 'package:bloc_paten/bloc/authbloc/auth_bloc.dart';
import 'package:bloc_paten/components/textfield/CustomFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _usernameError;
  String? _passwordError;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/logo.png',
                    height: 100,
                  ),
                  const SizedBox(height: 16.0),
                  CustomFormField(
                    controller: _usernameController,
                    labelText: 'Username',
                    errorText: _usernameError,
                    onChanged: (value) {
                      setState(() {
                        _usernameError = null;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  CustomFormField(
                    controller: _passwordController,
                    labelText: 'Password',
                    isPassword: true,
                    errorText: _passwordError,
                    onChanged: (value) {
                      setState(() {
                        _passwordError = null;
                      });
                    },
                  ),
                  const SizedBox(height: 32.0),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_usernameError == null &&
                              _passwordError == null) {
                            final username = _usernameController.text;
                            final password = _passwordController.text;
                            context.read<AuthBloc>().add(LoginRequested(
                                  username: username,
                                  password: password,
                                ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 20.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        child: const Text('Login'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
