import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/account_selector.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/fields.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/domain/services/auth.dart';
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

  // Services
  AuthService _authService = sl.get<AuthService>();

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
          // Complete user's account
          context.navigator.popAndPush(
              user.isCustomer ? Routes.homePage : Routes.dashboardPage);
        }
      });

      // Monitor authentication process
      _authService.onProcessingStateChanged.listen((state) {
        _isLoading = state == AuthState.AUTHENTICATING;
        if (mounted) setState(() {});
      });

      // Observe message state changes
      _authService.onMessageChanged.listen((message) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
              duration: const Duration(milliseconds: 1200),
              behavior: SnackBarBehavior.floating,
            ),
          );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<PrefsProvider>(
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
                bottom: kSpacingNone,
                top: getProportionateScreenHeight(kSpacingX120),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: getProportionateScreenHeight(kSpacingX64),
                            width: getProportionateScreenWidth(kSpacingX64),
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  getProportionateScreenWidth(kSpacingX16),
                            ),
                            child: Image(
                              image: Svg(provider.isLightTheme ? kLogoAsset : kLogoDarkAsset),
                              fit: BoxFit.contain,
                              height: getProportionateScreenHeight(kSpacingX64),
                              width: getProportionateScreenWidth(kSpacingX64),
                            ),
                          ),
                          Column(
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
                        ],
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(kSpacingX48)),
                      AnimatedContainer(
                        duration: kScaleDuration,
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                getProportionateScreenWidth(kSpacingX24)),
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
                                  height:
                                      getProportionateScreenHeight(kSpacingX4)),
                              Text(
                                kPasswordHint,
                                textAlign: TextAlign.center,
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
                                  : ButtonPrimary(
                                      width: SizeConfig.screenWidth * 0.7,
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
                          height: getProportionateScreenHeight(kSpacingX16)),
                      Text(
                        "or",
                        style: themeData.textTheme.button.copyWith(
                          color: themeData.colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(kSpacingX16)),
                      ButtonOutlined(
                        width: SizeConfig.screenWidth * 0.7,
                        themeData: themeData,
                        onTap: () => showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text("Continue as..."),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text("Artisan"),
                                  onTap: () {
                                    ctx.navigator.pop();
                                    _authService.signInWithGoogle(
                                        isCustomer: false);
                                  },
                                ),
                                ListTile(
                                  title: Text("Customer"),
                                  onTap: () {
                                    ctx.navigator.pop();
                                    _authService.signInWithGoogle(
                                        isCustomer: true);
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              ButtonClear(
                                text: "Cancel",
                                onPressed: () => ctx.navigator.pop(),
                                themeData: themeData,
                              ),
                            ],
                          ),
                        ),
                        gravity: ButtonIconGravity.START,
                        icon: AntDesign.google,
                        enabled: !_isLoading,
                        label: "Sign in with Google",
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(kSpacingX12)),
                      Divider(
                        indent: SizeConfig.screenWidth * 0.1,
                        endIndent: SizeConfig.screenWidth * 0.1,
                      ),
                      SizedBox(
                          height: getProportionateScreenHeight(kSpacingX12)),
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
                                    color: themeData.colorScheme.primary,
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
        ),
      ),
    );
  }
}
