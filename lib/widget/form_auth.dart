import 'package:flutter/material.dart';

class FormAuth extends StatefulWidget {
  FormAuth({Key? key, required this.submitForm}) : super(key: key);

  final Function(String username, String email, String password, bool isLogin)
      submitForm;

  @override
  State<FormAuth> createState() => _FormAuthState();
}

class _FormAuthState extends State<FormAuth> {
  bool isLogin = false;
  final _formKey = GlobalKey<FormState>();

  // VARIABLE VALIDATOR
  String _username = '';
  String _email = '';
  String _password = '';

  // FUNCTION BUTTON LOGIN
  void _trySubmit() {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitForm(_username, _email, _password, isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 200, horizontal: 20),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isLogin)

                    // VALIDATOR USERNAME
                    TextFormField(
                      key: ValueKey('username'),
                      onSaved: ((value) {
                        _username = value!;
                      }),
                      // ignore: body_might_complete_normally_nullable
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return "username minimal 4 akarakter";
                        }
                      },
                      decoration: InputDecoration(
                        label: Text("username"),
                      ),
                    ),

                  // VALIDATOR EMAIL
                  TextFormField(
                    key: ValueKey('email'),
                    onSaved: ((value) {
                      _email = value!;
                    }),
                    // ignore: body_might_complete_normally_nullable
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return "email tidak valid";
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: Text("email"),
                    ),
                  ),

                  // VALIDATOR PASSWORD
                  TextFormField(
                    key: ValueKey('password'),
                    onSaved: ((value) {
                      _password = value!;
                    }),
                    // ignore: body_might_complete_normally_nullable
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return "password minimal 6 karakter";
                      }
                    },
                    obscureText: true,
                    // keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      label: Text("password"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: isLogin ? Text("Login") : Text("Register"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: isLogin
                        ? Text("Create account")
                        : Text("I have already account"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
