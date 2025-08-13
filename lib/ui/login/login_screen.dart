import 'package:flutter/material.dart';
import 'package:flutter_checklist/ui/core/widgets/full_button.dart';
import 'package:flutter_checklist/ui/core/widgets/outlined_full_button.dart';
import 'package:flutter_checklist/ui/login/login_viewmodel.dart';
import 'package:flutter_checklist/utils/result.dart';

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
      widget.loginViewmodel.login.execute(
        (email: email, password: password),
      );
    }
  }

  void _createUser() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      widget.loginViewmodel.createUserAndLoggin.execute(
        (email: email, password: password),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      widget.loginViewmodel.login.addListener(checkError);
    }
  }

  checkError() {
    final loginCommand = widget.loginViewmodel.login;
    if (loginCommand.error) {
      final result = loginCommand.result as Error;
      if (result.error.contains('Failed to authenticate')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuário ou senha incorretos!'),
          ),
        );
      }
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
                  if (value.length < 8) {
                    return 'A senha precisa ser >= 8 caracteres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ListenableBuilder(
                listenable: widget.loginViewmodel.login,
                builder: (context, _) {
                  if (widget.loginViewmodel.login.running) {
                    return FullButton(
                      onPressed: () {},
                      label: 'Entrando...',
                    );
                  }
                  return FullButton(
                    onPressed: _login,
                    label: 'Entrar',
                  );
                },
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
    widget.loginViewmodel.login.removeListener(checkError);
    super.dispose();
  }
}
