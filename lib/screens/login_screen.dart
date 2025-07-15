import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/login_viewmodel.dart';
import '../app/app.dart';
import '../widgets/loading_dialog.dart';
import '../generated/l10n.dart';

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
        return S.of(context).requiredField;
      case LoginError.wrongEmail:
        return S.of(context).wrongEmail;
      case LoginError.wrongPassword:
        return S.of(context).wrongPassword;
      case LoginError.unknown:
        return S.of(context).unknownError;
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
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          'assets/images/app_icon.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Welcome Text
                      Text(
                        S.of(context).welcomeTitle,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        S.of(context).welcomeSubtitle,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Username Field
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: S.of(context).emailLabel,
                          hintText: S.of(context).emailHint,
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
                          labelText: S.of(context).passwordLabel,
                          hintText: S.of(context).passwordHint,
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
                          child: Text(S.of(context).loginButton),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Forget Password
                      TextButton(
                        onPressed: () => context.push(AppRouter.forgetPasswordRoute),
                        child: Text(
                          S.of(context).forgotPassword,
                          style: const TextStyle(color: Color(0xFF8B3A2E)),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Register Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(S.of(context).noAccount),
                          TextButton(
                            onPressed: () => context.push(AppRouter.registerRoute),
                            child: Text(
                              S.of(context).registerHere,
                              style: const TextStyle(
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