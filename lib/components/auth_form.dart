import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_learning_06/components/user_image_picker.dart';
import 'package:flutter_learning_06/models/auth_form_data.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formData = AuthFormData();
  final _formKey = GlobalKey<FormState>();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Theme.of(context).hintColor,
    ));
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    } else if (_formData.image == null && _formData.isSignup) {
      _showError("Por favor adicione uma imagem.");
    } else {
      widget.onSubmit(_formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_formData.isSignup)
                  UserImagePicker(
                    onImagePick: _handleImagePick,
                  ),
                if (_formData.isSignup)
                  TextFormField(
                    key: const ValueKey("name"),
                    initialValue: _formData.name,
                    onChanged: (name) => _formData.name = name,
                    decoration: const InputDecoration(
                      labelText: "Nome",
                    ),
                    validator: (_name) {
                      final name = _name ?? "";
                      if (name.trim().isEmpty) {
                        return "Nome não pode ser vazio.";
                      } else if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]')
                          .hasMatch(name)) {
                        return "O nome não pode conter caracteres especiais.";
                      } else {
                        return null;
                      }
                    },
                  ),
                TextFormField(
                  key: const ValueKey("email"),
                  initialValue: _formData.email,
                  onChanged: (email) => _formData.email = email,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                  validator: (_email) {
                    final email = _email ?? "";
                    if (email.trim().isEmpty) {
                      return "Email não pode ser vazio.";
                    } else if (RegExp(r'[!#\ $%^&*(),?":{}|<>]')
                        .hasMatch(email)) {
                      return "O email não pode conter caracteres especiais.";
                    }
                    if (!email.contains("@")) {
                      return "Email invalido.";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  key: const ValueKey("password"),
                  initialValue: _formData.password,
                  onChanged: (password) => _formData.password = password,
                  decoration: const InputDecoration(
                    labelText: "Senha",
                  ),
                  validator: (_password) {
                    final password = _password ?? "";
                    if (password.trim().isEmpty) {
                      return "Senha não pode ser vazia.";
                    } else if (password.length < 8) {
                      return "Senha precisa ter pelo menos 8 caracteres.";
                    } else if (!password.contains(RegExp(r'\d'))) {
                      return "Senha precisa conter pelo menos 1 número.";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(
                    _formData.isLogin ? "Entrar" : "Cadastrar",
                  ),
                ),
                TextButton(
                  child: Text(
                    _formData.isLogin
                        ? "Criar uma nova conta?"
                        : "Já possui conta? Faça seu Login",
                  ),
                  onPressed: () {
                    setState(() {
                      _formData.toggleAuthMode();
                    });
                  },
                )
              ],
            )),
      ),
    );
  }
}
