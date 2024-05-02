import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:websocket_chat_app/routes/app_route_contants.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../utils/color_helpers.dart';
import '../../utils/size_helpers.dart';
import '/screen/login/widgets/auth_form.dart';

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
                  context.go(AppRouteConstants.chatsScreen);
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
                        color: ColorHelpers.primaryColor,
                        fontSize: 24,
                      ),
                    ),
                    AuthForm(
                      formKey: _formKey,
                      usernameController: _usernameController,
                      passwordController: _passwordController,
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
                                color: ColorHelpers.primaryColor,
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
