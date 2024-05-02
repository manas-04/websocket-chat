import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat_app/utils/color_helpers.dart';

import '../../../bloc/auth/auth_bloc.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _usernameController = usernameController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
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
              obscureText: (context.read<AuthBloc>().obscureText),
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  onTap: () {
                    context
                        .read<AuthBloc>()
                        .add(TogglePasswordVisibiltyEvent());
                  },
                  child: Icon((context.read<AuthBloc>().obscureText)
                      ? Icons.visibility_off
                      : Icons.visibility),
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
              backgroundColor: ColorHelpers.primaryColor,
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
    );
  }
}
