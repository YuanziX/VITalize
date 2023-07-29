import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtop_app/1_app/pages/login_page/cubit/login_page_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Enter your Reg. ID and password to continue.",
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        _gap(),
        TextField(
          onChanged: (value) =>
              BlocProvider.of<LoginPageCubit>(context).usernameChanged(value),
          decoration: InputDecoration(
            labelText: 'Reg. ID',
            hintText: 'Enter your Reg. ID',
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        _gap(),
        TextField(
          onChanged: (value) =>
              BlocProvider.of<LoginPageCubit>(context).passwordChanged(value),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter your password',
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        _gap(),
        SizedBox(
          width: 125,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Sign in',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () =>
                BlocProvider.of<LoginPageCubit>(context).verifyCredentials(),
          ),
        ),
      ],
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
