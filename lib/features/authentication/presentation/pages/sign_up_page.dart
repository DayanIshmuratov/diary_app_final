import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создайте аккаунт"),
      ),
      body: widget(),
    );
  }

  Widget widget() {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _passwordCheckController = TextEditingController();
    return Column(
      children: [
        TextField(
          controller: _nameController,
        ),
        TextField(
          controller: _emailController,
        ),
        TextField(
          controller: _passwordController,
        ),
        TextField(
          controller: _passwordCheckController,
        ),
        ElevatedButton(
          onPressed: () {

          },
          child: Text("Регаться"),
        )
      ],
    );
  }
}

