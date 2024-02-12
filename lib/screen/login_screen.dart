import 'package:dicoding_moments/common.dart';
import 'package:dicoding_moments/model/user.dart';
import 'package:dicoding_moments/provider/auth_provider.dart';
import 'package:dicoding_moments/routes/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;

  const LoginScreen({
    Key? key,
    required this.onLogin,
    required this.onRegister,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.loginTitleAppBar ?? "Login",
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                              ?.handleEmptyTextEmailAuth ??
                          'Please enter your email.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)?.hintTextEmailAuth ??
                        "Email",
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(context)?.hintTextPasswordAuth ??
                            "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                              ?.handleEmptyTextPasswordAuth ??
                          'Please enter your password.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                context.watch<AuthProvider>().isLoadingLogin
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final scaffoldMessenger =
                                ScaffoldMessenger.of(context);
                            final User user = User(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            final authRead = context.read<AuthProvider>();

                            final result = await authRead.login(user);
                            if (result) {
                              widget.onLogin();
                            } else {
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text(
                                      authRead.message ?? "Failed to login"),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          AppLocalizations.of(context)?.loginTextButton ??
                              "LOGIN",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () async {
                    widget.onRegister();
                    final scaffoldMessenger = ScaffoldMessenger.of(context);
                    if (context.mounted) {
                      final dataString =
                          await context.read<PageManager>().waitForResult();
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text(dataString),
                        ),
                      );
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)?.registerTextButton ??
                        "REGISTER",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
