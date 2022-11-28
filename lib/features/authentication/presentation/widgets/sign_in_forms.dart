import 'package:diary_app_final/core/validators/validator.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_bloc.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_event.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/cubit_auth/auth_cubit.dart';
import 'package:diary_app_final/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInTextForm extends StatefulWidget {
  const SignInTextForm({Key? key}) : super(key: key);

  @override
  State<SignInTextForm> createState() => _SignInTextFormState();
}
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _SignInTextFormState extends State<SignInTextForm> {
  final _key = GlobalKey<FormState>();
  bool _isHide = true;
  Widget build(BuildContext context) {
    final _bloc = context.read<BlocAuthBloc>();
    return SingleChildScrollView(
      child: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      hintText: "Почта",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.red),
                      )
                  ),
                  controller: _emailController,
                  validator: (value) {
                    return Validator.validateEmail(email: value as String);
                  }
              ),
              SizedBox(height: 8,),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(onPressed: () {
                      _isHide = !_isHide;
                      setState(() {});
                    },
                        icon: Icon(_isHide ? Icons.visibility : Icons.visibility_off)
                    ),
                    hintText: "Пароль",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                ),
                obscureText: _isHide,
                controller: _passwordController,
                validator: (value) => Validator.validatePassword(password: value as String),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    _bloc.add(BlocAuthSignInEvent(email: _emailController.text, password: _passwordController.text));
                  }
                  // context.read<AuthCubit>().launch();
                },
                child: Text("Войти"),
              ),
              OutlinedButton(onPressed: () {
                Navigator.pushNamed(context, "/sign_up_page");
              }, child: Text("Регистрация")),
            ],
          ),
        ),
      ),
    );
  }
}