import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../actions/index.dart';
import '../models/index.dart';
import 'containers/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _onNext() {
    final String email = _email.text;
    final String password = _password.text;

    // check if email is valid
    if (!EmailValidator.validate(email)) {
      return;
    }

    StoreProvider.of<AppState>(context).dispatch(
      LoginUserStart(
        email: email,
        password: password,
        result: _onResult,
      ),
    );
  }

  void _onResult(dynamic action) {
    if (action is LoginUserSuccessful) {
      Navigator.pushReplacementNamed(context, '/');
    } else if (action is LoginUserError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${action.error}'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _email,
                decoration: const InputDecoration(
                  hintText: 'email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _password,
                decoration: const InputDecoration(
                  hintText: 'password',
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              const SizedBox(
                height: 32,
              ),
              PendingContainer(
                builder: (BuildContext context, Set<String> pending) {
                  if (pending.contains(LoginUser.pendingKey)) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: _onNext,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Don't have an account?",
                  ),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/createUser',
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
