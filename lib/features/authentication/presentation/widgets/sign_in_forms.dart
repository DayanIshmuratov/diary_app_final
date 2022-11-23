import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_bloc.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_event.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/cubit_auth/auth_cubit.dart';
import 'package:diary_app_final/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignInTextForm extends StatelessWidget {
  Widget build(BuildContext context) {
    final _bloc = context.read<BlocAuthBloc>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.red),
              )
            ),
            controller: _emailController,
          ),
          SizedBox(height: 8,),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                )
            ),
            controller: _passwordController,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(

            ),
            onPressed: () {
              _bloc.add(BlocAuthSignInEvent(email: _emailController.text, password: _passwordController.text));
              // context.read<AuthCubit>().launch();
            },
            child: Text("Войти"),
          ),
          OutlinedButton(onPressed: () {
            Navigator.pushNamed(context, "/sign_up_page");
          }, child: Text("Регистрация")),
        ],
      ),
    );
  }
}