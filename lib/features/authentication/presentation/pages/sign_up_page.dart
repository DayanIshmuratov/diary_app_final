import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_bloc.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_state.dart';
import 'package:diary_app_final/features/authentication/presentation/widgets/sign_up_forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создайте аккаунт"),
      ),
      body: BlocBuilder<BlocAuthBloc, BlocAuthState>(
          builder: (context, state) {
            if (state is BlocAuthInitState) {
              return SignUpForm();
            } else if (state is BlocAuthErrorState) {
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), duration: Duration(seconds: 5),));
              print('${state.message}');
              return SignUpForm();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
      ),
    );
  }
}

