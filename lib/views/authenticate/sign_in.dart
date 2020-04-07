import 'package:flutter/material.dart';
import 'package:home_workouts/service/auth_service.dart';
import 'package:home_workouts/views/authenticate/register.dart';
import 'package:home_workouts/views/shared/buttons/primary_button.dart';
import 'package:home_workouts/views/shared/buttons/secondary_button.dart';
import 'package:home_workouts/views/shared/loading.dart';
import 'package:home_workouts/views/shared/padding.dart';
import 'package:home_workouts/views/shared/scroll_behavior.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final AuthService _authService = AuthService();

  // Form Keys
  final _formKey = GlobalKey<FormState>();

  // Form data
  String email = "";
  String password = "";

  String error = "";

  // Loading data
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                'Sign in bro',
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
                          validator: (val) =>
                              val.isEmpty ? "Invalid email" : null,
                          decoration: new InputDecoration(
                            labelText: "Email address",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          obscureText: true,
                          validator: (val) => val.isEmpty
                              ? "Please put in your password"
                              : null,
                          decoration: new InputDecoration(
                            labelText: "Password",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        PrimaryButton("Sign in", () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _loading = true;
                            });
                            dynamic result =
                                await _authService.signIn(email, password);
                            if (result == null) {
                              setState(() {
                                _loading = false;
                                error =
                                    "Couldn't sign in, check password or email";
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
                          "Register instead",
                          () async {
                            await Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return RegisterView();
                            }));
                          },
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
