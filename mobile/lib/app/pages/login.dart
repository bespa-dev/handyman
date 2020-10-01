import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/fields.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController(text: "dummyuser@gmail.com"),
      _passwordController = TextEditingController(text: "dummy@1234");

  // Perform login
  void _performLogin() async {
    _formKey.currentState.save();
    setState(() {
      _isLoading = !_isLoading;
    });
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // TODO: SEND TO SERVER FOR AUTHENTICATION

    // Complete user's account
    context.navigator.popAndPush(Routes.accountSelectionPage);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<ThemeProvider>(
        builder: (_, provider, __) => SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              provider.isLightTheme
                  ? Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(kBackgroundAsset),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              // Positioned(
              //   top: getProportionateScreenHeight(kSpacingX36),
              //   left: getProportionateScreenWidth(kSpacingX64),
              //   right: getProportionateScreenWidth(kSpacingX64),
              //   child: Container(
              //     child: Image.asset(
              //       kLogoAsset,
              //       fit: BoxFit.contain,
              //       height: kToolbarHeight,
              //       width: double.infinity,
              //     ),
              //   ),
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(kSpacingX48)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back!",
                          style: themeData.textTheme.headline4,
                        ),
                        SizedBox(
                            height: getProportionateScreenHeight(kSpacingX8)),
                        Text(
                          "Sign in to your account",
                          style: themeData.textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(kSpacingX48)),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(kSpacingX48)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormInput(
                            controller: _emailController,
                            labelText: "Email address",
                            color: themeData.textTheme.bodyText1.color,
                            textInputAction: TextInputAction.next,
                            enabled: !_isLoading,
                            validator: (input) =>
                                !EmailValidator.validate(input)
                                    ? "Enter a valid email address"
                                    : null,
                          ),
                          PasswordInput(
                            controller: _passwordController,
                            labelText: "Password",
                            onFieldSubmitted: (_) => _performLogin(),
                            enabled: !_isLoading,
                            validator: (input) =>
                                input.isEmpty || input.length < 6
                                    ? "Enter a valid password"
                                    : null,
                          ),
                          ButtonOutlined(
                            width: getProportionateScreenWidth(kSpacingX200),
                            themeData: themeData,
                            onTap: _performLogin,
                            enabled: !_isLoading,
                            icon: Icons.arrow_right_alt,
                            label: "Sign in",
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(kSpacingX64)),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Are you a new user? ",
                          style: themeData.textTheme.bodyText1,
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: themeData.textTheme.bodyText1.copyWith(
                                color: themeData.primaryColor,
                              ),
                              semanticsLabel: "Create account",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context.navigator
                                    .popAndPush(Routes.registerPage),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
