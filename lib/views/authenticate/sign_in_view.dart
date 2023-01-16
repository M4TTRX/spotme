import 'package:flutter/material.dart';
import 'package:spotme/model/account_model.dart';
import 'package:spotme/service/auth_service.dart';
import 'package:spotme/service/service.dart';
import 'package:spotme/views/authenticate/sign_up_view.dart';
import 'package:spotme/views/main_navigation/main_navigarion_view.dart';
import 'package:spotme/views/shared/buttons/primary_button.dart';
import 'package:spotme/views/shared/buttons/secondary_button.dart';
import 'package:spotme/views/shared/loading_view.dart';
import 'package:spotme/views/shared/padding.dart';
import 'package:spotme/views/shared/scroll_behavior.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/layout_values.dart';
import '../shared/buttons/buttonStyles.dart';

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

  // error data
  String error = "";

  // Loading data
  bool _loading = false;
  bool _signedIn = false;

  @override
  Widget build(BuildContext context) {
    return _signedIn
        ? MainNavigationView()
        : _loading
            ? Loading()
            : Scaffold(
                body: ScrollConfiguration(
                  behavior: BasicScrollBehaviour(),
                child: Container(
                  padding: containerPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[                    
                      SizedBox(
                        height: LayoutValues.LARGE,
                      ),
                      Text(
                        "Log in",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SvgPicture.asset(
                        "resources/images/visuals/undraw_personal_trainer_2.svg",
                        height: 156,
                        width: 156,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your email",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                SizedBox(
                                  height: LayoutValues.SMALL,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) =>
                                      val!.isEmpty ? "Invalid email" : null,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  decoration: new InputDecoration(
                                    hintText: "Email address",
                                  ),
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                ),
                                SizedBox(
                                  height: LayoutValues.MEDIUM,
                                ),
                                Text(
                                  "Your password",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                SizedBox(
                                  height: LayoutValues.SMALL,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  validator: (val) => val!.isEmpty
                                      ? "Please put in your password"
                                      : null,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  decoration: new InputDecoration(
                                    hintText: "Password",
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(8.0),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: LayoutValues.MEDIUM,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: Text("Register"),
                                  onPressed: () async {
                                    await Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) {
                                      // TODO migrate functions to the authservice
                                      AppService service =
                                          AppService(account: Account());
                                      return SignUpView(
                                        service: service,
                                      );
                                    }));
                                  },
                                  style: ButtonStyles.greyButton(context),
                                ),
                                SizedBox(
                                  width: LayoutValues.SMALL,
                                ),
                                ElevatedButton(
                                  child: Text("Log In"),
                                  style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                            Size(128, 48)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .primaryContainer),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _loading = true;
                                      });
                                      dynamic result = await _authService
                                          .signIn(email, password);
                                      setState(() {
                                        _loading = false;
                                        if (result == null) {
                                          error =
                                              "Couldn't sign in, check password or email";
                                        } else {
                                          _signedIn = true;
                                        }
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                            Text(
                              error,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: LayoutValues.SMALLER,
                      ),
                    ],
                  ),
                ),
                ));
  }
}
