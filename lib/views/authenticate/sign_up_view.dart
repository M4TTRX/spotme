import 'package:flutter/material.dart';
import 'package:spotme/service/service.dart';
import 'package:spotme/theme/layout_values.dart';
import 'package:spotme/views/authenticate/sign_in_view.dart';
import 'package:spotme/views/shared/buttons/primary_button.dart';
import 'package:spotme/views/shared/buttons/secondary_button.dart';
import 'package:spotme/views/shared/padding.dart';
import 'package:spotme/views/shared/scroll_behavior.dart';

import '../shared/buttons/buttonStyles.dart';

class SignUpView extends StatefulWidget {
  AppService service;
  SignUpView({required this.service});

  @override
  _SignUpViewState createState() => _SignUpViewState(service);
}

class _SignUpViewState extends State<SignUpView> {
  _SignUpViewState(this.service);
  AppService service;

  // Form Keys
  final _formKey = GlobalKey<FormState>();

  // Form data
  String username = "";
  String email = "";
  String password = "";
  String passwordValidate = "";

  // error data
  String error = "";

  // Loading data

  void _goToSignIn() async {
    await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) {
      return SignInView();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScrollConfiguration(
      behavior: BasicScrollBehaviour(),
      child: ListView(
        reverse: true,
        padding: containerPadding,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: LayoutValues.LARGE,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(
                      height: LayoutValues.SMALL,
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: "Username",
                        border: new OutlineInputBorder(
                          borderRadius:
                              new BorderRadius.circular(LayoutValues.SMALL),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() => username = val);
                      },
                      validator: (val) =>
                          val!.isEmpty ? "Username required" : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: LayoutValues.SMALL),
                      child: Text(
                        "Email",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
           
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                        hintText: "Email address",
                        border: new OutlineInputBorder(
                          borderRadius:
                              new BorderRadius.circular(LayoutValues.SMALL),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      validator: (val) => val!.isEmpty &&
                              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email)
                          ? "Invalid email"
                          : null,
                    ),
                    Text(
                      error,
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                    Text(
                      "Password",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(
                      height: LayoutValues.SMALL,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        if (val!.length < 8) {
                          return "Password mus be at least 8 characters long";
                        }
                        if (password != passwordValidate) {
                          return "Passwords must match";
                        }
                        return null;
                      },
                      decoration: new InputDecoration(
                        hintText: "Password",
                        border: new OutlineInputBorder(
                          borderRadius:
                              new BorderRadius.circular(LayoutValues.SMALL),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: LayoutValues.MEDIUM,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        if (password != passwordValidate) {
                          return "Passwords must match";
                        }
                        return null;
                      },
                      decoration: new InputDecoration(
                        hintText: "Please Re-Enter password correctly",
                        border: new OutlineInputBorder(
                          borderRadius:
                              new BorderRadius.circular(LayoutValues.SMALL),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      onChanged: (val) {
                        setState(() => passwordValidate = val);
                      },
                    ),
                    SizedBox(
                      height: LayoutValues.LARGE,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text("Login"),
                      onPressed: _goToSignIn,
                      style: ButtonStyles.greyButton(context),
                    ),
                    SizedBox(
                      width: LayoutValues.SMALL,
                    ),
                    ElevatedButton(
                      child: Text("Register"),
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(128, 48)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.onPrimaryContainer),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.primaryContainer),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dynamic result = await service.registerUser(
                              username, email, password);
                          setState(() {});
                          if (result == null) {
                            setState(() {
                              error =
                                  "Your email is probably invalid or already used";
                            });
                          }
                          print(email);
                          print(password);
                          _goToSignIn();
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: LayoutValues.LARGE,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
