import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/login_viewmodel.dart';
import '../app/app.dart';
import '../widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _getErrorMessage(LoginError error) {
    switch (error) {
      case LoginError.requiredField:
        return 'Este campo é obrigatório';
      case LoginError.wrongEmail:
        return 'Email incorreto';
      case LoginError.wrongPassword:
        return 'Senha incorreta';
      case LoginError.unknown:
        return 'Erro desconhecido';
      case LoginError.none:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          // Listen to login success
          if (viewModel.isLoginSuccessful) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go(AppRouter.mainRoute);
              viewModel.resetLoginState();
            });
          }

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App Icon
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B3A2E),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.shopping_bag,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Welcome Text
                      const Text(
                        'Bem vindo ao TryOn!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Prove e Aprove',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Username Field
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Insira o seu email',
                          errorText: viewModel.usernameError != LoginError.none
                              ? _getErrorMessage(viewModel.usernameError)
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          viewModel.username = value;
                          viewModel.clearErrors();
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          hintText: 'Insira a sua senha',
                          errorText: viewModel.passwordError != LoginError.none
                              ? _getErrorMessage(viewModel.passwordError)
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          viewModel.password = value;
                          viewModel.clearErrors();
                        },
                      ),
                      const SizedBox(height: 24),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: viewModel.isLoading ? null : viewModel.performLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B3A2E),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Entrar'),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Forget Password
                      TextButton(
                        onPressed: () => context.push(AppRouter.forgetPasswordRoute),
                        child: const Text(
                          'Esqueceu a senha? Clique aqui',
                          style: TextStyle(color: Color(0xFF8B3A2E)),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Register Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Ainda não tem uma conta?'),
                          TextButton(
                            onPressed: () => context.push(AppRouter.registerRoute),
                            child: const Text(
                              'Clique Aqui!',
                              style: TextStyle(
                                color: Color(0xFF8B3A2E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (viewModel.isLoading) const LoadingDialog(),
            ],
          );
        },
      ),
    );
  }
} 