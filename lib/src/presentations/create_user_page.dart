import 'package:email_validator/email_validator.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../actions/index.dart';
import '../models/index.dart';
import 'containers/index.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();
  final FancyPasswordController _passwordFancy = FancyPasswordController();
  final FancyPasswordController _passwordConfirmFancy = FancyPasswordController();

  void _onNext() {
    final String email = _email.text;
    final String password = _password.text;
    final String passwordConfirm = _passwordConfirm.text;

    // check if email is valid
    if (!EmailValidator.validate(email)) {
      return;
    }

    // check if password is valid
    if (password != passwordConfirm) {
      return;
    }

    StoreProvider.of<AppState>(context).dispatch(
      CreateUserStart(
        email: email,
        password: password,
        result: _onResult,
      ),
    );
  }

  void _onResult(dynamic action) {
    if (action is CreateUserSuccessful) {
      Navigator.pushReplacementNamed(context, '/');
    } else if (action is CreateUserError) {
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
      resizeToAvoidBottomInset: false,
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
              FancyPasswordField(
                controller: _password,
                decoration: const InputDecoration(
                  hintText: 'password',
                ),
                passwordController: _passwordFancy,
                validationRules: <ValidationRule>{
                  DigitValidationRule(),
                  UppercaseValidationRule(),
                  SpecialCharacterValidationRule(),
                  MinCharactersValidationRule(6),
                },
                validator: (String? value) {
                  return _passwordFancy.areAllRulesValidated ? null : 'Password is not valid';
                },
                validationRuleBuilder: (Set<ValidationRule> rules, String value) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: rules
                          .map(
                            (ValidationRule rule) => rule.validate(value)
                                ? Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        rule.name,
                                        style: const TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        rule.name,
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                          )
                          .toList(),
                    ),
                  );
                },
              ),
              FancyPasswordField(
                controller: _passwordConfirm,
                passwordController: _passwordConfirmFancy,
                decoration: const InputDecoration(
                  hintText: 'confirm password',
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              PendingContainer(
                builder: (BuildContext context, Set<String> pending) {
                  if (pending.contains(CreateUser.pendingKey)) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: _onNext,
                    child: const Text(
                      'Create',
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
                    'Already have an account?',
                  ),
                  TextButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/login',
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
