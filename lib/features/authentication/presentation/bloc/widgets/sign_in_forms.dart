import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_auth/bloc_auth_event.dart';

class SignInTextForm extends StatelessWidget {
  Widget build(BuildContext context) {
    final _bloc = context.read<BlocAuthBloc>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return Column(
      children: [
        TextField(
          controller: _emailController,
        ),
        TextField(
          controller: _passwordController,
        ),
        ElevatedButton(
          onPressed: () {
            _bloc.add(BlocAuthSignInEvent(email: _emailController.text, password: _passwordController.text));
            // context.read<AuthCubit>().launch();
          },
          child: Text("Войти"),
        )
      ],
    );
  }
}