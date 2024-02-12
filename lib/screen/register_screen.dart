import 'package:dicoding_moments/common.dart';
import 'package:dicoding_moments/provider/auth_provider.dart';
import 'package:dicoding_moments/routes/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onRegister;
  final Function() onLogin;

  const RegisterScreen({
    Key? key,
    required this.onRegister,
    required this.onLogin,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
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
          AppLocalizations.of(context)?.registerTitleAppBar ?? "Register",
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
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                              ?.handleEmptyTextNameAuth ??
                          'Please enter your name.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)?.hintTextNameAuth ??
                        "Name",
                  ),
                ),
                const SizedBox(height: 8),
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
                context.watch<AuthProvider>().isLoadingRegister
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final User user = User(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            final authRead = context.read<AuthProvider>();

                            final result = await authRead.register(user);
                            if (result) {
                              widget.onRegister();
                              if (context.mounted) {
                                context.read<PageManager>().returnData(authRead
                                        .message ??
                                    'Register Failed, Please contact customer service');
                              }
                            } else {
                              if (context.mounted) {
                                final scaffoldMessenger =
                                    ScaffoldMessenger.of(context);
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    content: Text(authRead.message ??
                                        'Register Failed, Please contact customer service'),
                                  ),
                                );
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          AppLocalizations.of(context)?.registerTextButton ??
                              "REGISTER",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => widget.onLogin(),
                  child: Text(
                    AppLocalizations.of(context)?.loginTextButton ?? "LOGIN",
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
