import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/fields.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController(text: "dummyuser@gmail.com"),
      _passwordController = TextEditingController(text: "dummy@1234"),
      _nameController = TextEditingController(text: "Michael Pinto");

  // Perform login
  void _performRegister() async {
    _formKey.currentState.save();
    setState(() {
      _isLoading = !_isLoading;
    });
    final username = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // TODO: SEND TO SERVER FOR AUTHENTICATION

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = !_isLoading;
    });

    Provider.of<PrefsProvider>(context, listen: false).saveUserId(Uuid().v4());
    // Complete user's account
    context.navigator.popAndPush(Routes.accountCompletionPage);
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
              Positioned(
                top: getProportionateScreenHeight(kSpacingX36),
                left: getProportionateScreenWidth(kSpacingX64),
                right: getProportionateScreenWidth(kSpacingX64),
                child: Container(
                  child: Image.asset(
                    kLogoAsset,
                    fit: BoxFit.contain,
                    height: kToolbarHeight,
                    width: double.infinity,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(kSpacingX24)),
                    child: Text(
                      "Sign up with us to get started",
                      style: themeData.textTheme.headline4,
                      textAlign: TextAlign.center,
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
                            controller: _nameController,
                            labelText: "Full Name",
                            textInputAction: TextInputAction.next,
                            enabled: !_isLoading,
                            validator: (input) =>
                                !EmailValidator.validate(input)
                                    ? "Enter your full name"
                                    : null,
                            keyboardType: TextInputType.name,
                          ),
                          TextFormInput(
                            controller: _emailController,
                            labelText: "Email address",
                            textInputAction: TextInputAction.next,
                            enabled: !_isLoading,
                            keyboardType: TextInputType.emailAddress,
                            validator: (input) =>
                                !EmailValidator.validate(input)
                                    ? "Enter a valid email address"
                                    : null,
                          ),
                          PasswordInput(
                            controller: _passwordController,
                            labelText: "Password",
                            onFieldSubmitted: (_) => _performRegister(),
                            enabled: !_isLoading,
                            validator: (input) =>
                                input.isEmpty || input.length < 6
                                    ? "Enter a valid password"
                                    : null,
                          ),
                          ButtonOutlined(
                            width: getProportionateScreenWidth(kSpacingX200),
                            themeData: themeData,
                            onTap: _performRegister,
                            enabled: !_isLoading,
                            icon: Icons.arrow_right_alt,
                            label: "Sign up",
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
                          text: "Already have an account? ",
                          style: themeData.textTheme.bodyText1,
                          children: [
                            TextSpan(
                              text: "Sign in instead",
                              style: themeData.textTheme.bodyText1.copyWith(
                                color: themeData.primaryColor,
                              ),
                              semanticsLabel: "Sign in",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context.navigator
                                    .popAndPush(Routes.loginPage),
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
