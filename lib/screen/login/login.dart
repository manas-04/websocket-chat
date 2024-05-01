import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_route_contants.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../utils/size_helpers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.all(SizeHelpers.screenWidth(context) * 0.05),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                } else if (state is AuthFailedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                } else if (state is AuthSuccessState) {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRouteConstants.chatsScreen,
                  );
                }
              },
              builder: (context, state) => Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Hi, there!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 95, 107),
                        fontSize: 24,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: TextFormField(
                              controller: _usernameController,
                              key: const ValueKey('userName'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your userName.";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'User Name',
                                prefixIcon: const Icon(Icons.person),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 20,
                                ),
                                hintText: "User Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: TextFormField(
                              controller: _passwordController,
                              key: const ValueKey('password'),
                              obscureText:
                                  (state is! PasswordVisibilityOnState),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(TogglePasswordVisibiltyEvent());
                                  },
                                  child: Icon(
                                    (state is PasswordVisibilityOnState)
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 20,
                                ),
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return "Please enter a Password.";
                                } else if (!regex.hasMatch(value)) {
                                  return "Enter a valid password minimum 6 characters long.";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () => {
                              context.read<AuthBloc>().add(
                                    AuthButtonClickEvent(
                                      key: _formKey,
                                      userName: _usernameController.text,
                                      password: _passwordController.text,
                                      isLoginFlow: true,
                                    ),
                                  ),
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 95, 107),
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account ?",
                        ),
                        InkWell(
                          onTap: () => {
                            context.read<AuthBloc>().add(
                                  AuthButtonClickEvent(
                                    key: _formKey,
                                    userName: _usernameController.text,
                                    password: _passwordController.text,
                                    isLoginFlow: false,
                                  ),
                                ),
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 95, 107),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
