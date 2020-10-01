import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/account_selector.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/fields.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/services/auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _isCustomer = true;
  UserAccountPicker _accountPicker = UserAccountPicker.CUSTOMER;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController(),
      _passwordController = TextEditingController();
  final _authService = sl.get<FirebaseAuthService>();
  PrefsProvider _prefsProvider;

  // Perform login
  void _performLogin() async {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      // Sign in
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
        isCustomer: _isCustomer,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      // Monitor user auth state change
      _authService.onAuthStateChanged.listen((user) {
        if (user != null) {
          // Save to prefs
          _prefsProvider.saveUserId(user.user.id);
          _prefsProvider
              .saveUserType(user.isCustomer ? kClientString : kProviderString);

          // Complete user's account
          context.navigator.popAndPush(
              user.isCustomer ? Routes.homePage : Routes.dashboardPage);
        }
      });

      // Monitor authentication process
      _authService.onProcessingStateChanged.listen((state) {
        _isLoading = state;
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _authService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<PrefsProvider>(
        builder: (_, provider, __) {
          _prefsProvider = provider;
          return SafeArea(
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
                  bottom: kSpacingNone,
                  top: kSpacingX120,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  getProportionateScreenWidth(kSpacingX48)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome back.",
                                style: themeData.textTheme.headline4,
                              ),
                              SizedBox(
                                  height:
                                      getProportionateScreenHeight(kSpacingX8)),
                              Text(
                                "Sign in to your account",
                                style: themeData.textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: getProportionateScreenHeight(kSpacingX48)),
                        AnimatedContainer(
                          duration: kScaleDuration,
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  getProportionateScreenWidth(kSpacingX48)),
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
                                SizedBox(
                                    height: getProportionateScreenHeight(
                                        kSpacingX4)),
                                Text(
                                  "Your password must be 8 or more characters long & must container a mix of upper & lower case letters, numbers & symbols",
                                  style: themeData.textTheme.caption,
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(
                                        kSpacingX16)),
                                UserAccountSelector(
                                  enabled: !_isLoading,
                                  accountPicker: _accountPicker,
                                  onAccountSelected: (picker) {
                                    _accountPicker = picker;
                                    _isCustomer = _accountPicker ==
                                        UserAccountPicker.CUSTOMER;
                                    setState(() {});
                                  },
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(
                                        kSpacingX24)),
                                _isLoading
                                    ? CircularProgressIndicator()
                                    : ButtonOutlined(
                                        width: getProportionateScreenWidth(
                                            kSpacingX200),
                                        themeData: themeData,
                                        onTap: _performLogin,
                                        enabled: !_isLoading,
                                        icon: Icons.arrow_right_alt,
                                        label: "Sign in",
                                      ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: getProportionateScreenHeight(kSpacingX64)),
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
                                    style:
                                        themeData.textTheme.bodyText1.copyWith(
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
