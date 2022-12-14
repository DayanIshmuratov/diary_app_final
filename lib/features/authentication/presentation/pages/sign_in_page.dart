import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_event.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_state.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/cubit_auth/auth_cubit.dart';
import 'package:diary_app_final/features/authentication/presentation/widgets/sign_in_forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_auth/bloc_auth_bloc.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Войдите в свой аккаунт"),
      ),
      body: BlocListener<BlocAuthBloc, BlocAuthState>(
        listener: (context, state) {
          if (state is BlocAuthErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message), duration: Duration(seconds: 5),));
          }
        },
        child: BlocBuilder<BlocAuthBloc, BlocAuthState>(
            builder: (context, state) {
              if (state is BlocAuthInitState) {
                return SignInTextForm();
              }  else {
                return const Center(child: CircularProgressIndicator());
              }
            }
        ),
      ),
    );
  }
}


