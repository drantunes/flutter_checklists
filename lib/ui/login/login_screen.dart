import 'package:flutter/material.dart';
import 'package:flutter_checklist/ui/core/widgets/full_button.dart';
import 'package:flutter_checklist/ui/core/widgets/outlined_full_button.dart';
import 'package:flutter_checklist/ui/login/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  final LoginViewmodel loginViewmodel;

  const LoginScreen({super.key, required this.loginViewmodel});

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      widget.loginViewmodel.login(email, password);
    }
  }

  void _createUser() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      widget.loginViewmodel.createUserAndLoggedIn(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acesse sua Conta'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe seu email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe sua senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              FullButton(
                onPressed: _login,
                label: 'Entrar',
              ),
              SizedBox(height: 24),
              OutlinedFullButton(
                onPressed: _createUser,
                label: 'Criar conta e entrar',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
