import 'package:flutter/material.dart';
import 'package:home_workouts/service/auth_service.dart';
import 'package:home_workouts/views/authenticate/sign_in.dart';
import 'package:home_workouts/views/shared/buttons/primary_button.dart';
import 'package:home_workouts/views/shared/buttons/secondary_button.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/scroll_behavior.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final AuthService _authService = AuthService();

  // Form Keys
  final _formKey = GlobalKey<FormState>();

  // Form data
  String email = "";
  String password = "";
  String passwordValidate = "";

  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            'Register bro',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ScrollConfiguration(
          behavior: BasicScrollBehaviour(),
          child: ListView(
            padding: containerPadding,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                        labelText: "Email address",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      validator: (val) => val.isEmpty ? "Invalid email" : null,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        if (val.length < 8) {
                          return "Password mus be at least 8 characters long";
                        }
                        if (password != passwordValidate) {
                          return "Passwords must match";
                        }
                        return null;
                      },
                      decoration: new InputDecoration(
                        labelText: "Password",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 24,
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
                        labelText: "Validate Password",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      onChanged: (val) {
                        setState(() => passwordValidate = val);
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    PrimaryButton("Register", () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _authService
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error =
                                "Your email is probably invalid or already used";
                          });
                        }
                        print(email);
                        print(password);
                      }
                    }),
                    SizedBox(
                      height: 8,
                    ),
                    SecondaryButton(
                      "Sign In instead",
                      () async {
                        await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return SignInView();
                        }));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
