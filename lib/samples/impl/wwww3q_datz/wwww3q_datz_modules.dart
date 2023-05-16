// ignore_for_file: camel_case_types

import '../../interface/sample_interface.dart';

class Wwww3qDatz_authentication_binding_Sample extends Sample {
  Wwww3qDatz_authentication_binding_Sample() : super('lib/app/modules/authentication/bindings/authentication_binding.dart', overwrite: true);

  @override
  String get content => '''
import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );
  }
}
''';
}

class Wwww3qDatz_authentication_controller_Sample extends Sample {
  Wwww3qDatz_authentication_controller_Sample() : super('lib/app/modules/authentication/controllers/authentication_controller.dart', overwrite: true);

  @override
  String get content => '''
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../core/base/base_project.dart';
import '../../../core/constants/app_constant.dart';
import '../../../core/utils/utils.dart';
import '../../../models/users_model.dart';

class AuthenticationController extends BaseController {
  static UsersModel? userAccount;
  final formSignInKey = GlobalKey<FormBuilderState>();
  final formSignUpKey = GlobalKey<FormBuilderState>();
  final formForgotPasswordKey = GlobalKey<FormBuilderState>();
  bool isRememberPassword = true;

  @override
  void onInit() {
    super.onInit();
    onInitData();
  }

  Future<void> onInitData() async {
    final userAccountString = Global.sharedPreferences.getString(StorageConstants.userAccount);
    if (userAccountString != null) {
      userAccount = UsersModel().fromJson(jsonDecode(userAccountString));
      //set field username, password
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        formSignInKey.currentState?.fields['email']?.didChange(userAccount?.email);
        formSignInKey.currentState?.fields['password']?.didChange(userAccount?.password);
      });
    }
  }

  void onSignIn() {
    if (formSignInKey.currentState?.saveAndValidate() ?? false) {
      apiCall
          .onRequest(
        ApiUrl.post_auth_login(),
        RequestMethod.POST,
        body: formSignInKey.currentState?.value,
        baseModel: UsersModel(),
      )
          .then((result) {
        if (result == null) return;
        userAccount = result as UsersModel;
        //luu lai username, password
        _saveRememberPassword(userAccount!..password = formSignInKey.currentState?.value['password']);

        Get.toNamed('/home');
      });
    }
    // else {
    //   Printt.white(formSignInKey.currentState?.value.toString());
    //   Printt.white('validation failed');
    // }
  }

  void onSignUp() {
    if (formSignUpKey.currentState?.saveAndValidate() ?? false) {
      apiCall.onRequest(
        ApiUrl.post_auth_register(),
        RequestMethod.POST,
        body: {
          ...formSignUpKey.currentState!.value,
        },
      ).then((result) {
        if (result == null) return;
        HelperWidget.showSnackBar(message: result['message']);
      });
    }
  }

  void onSignOut() {
    saveAccount(null);
    Get.toNamed('/authentication');
  }

  void onTryApp() {
    Get.toNamed('/home');
  }

  void saveAccount(UsersModel? user) {
    (user == null)
        ? Global.sharedPreferences.remove(StorageConstants.userAccount)
        : Global.sharedPreferences.setString(StorageConstants.userAccount, jsonEncode(user.toJson()));
  }

  void _saveRememberPassword(UsersModel user) {
    isRememberPassword ? saveAccount(user) : saveAccount(null);
  }

  void onForgotPassword() {
    if (formForgotPasswordKey.currentState?.saveAndValidate() ?? false) {}
  }
}
''';
}

class Wwww3qDatz_authentication_view_Sample extends Sample {
  Wwww3qDatz_authentication_view_Sample() : super('lib/app/modules/authentication/views/authentication_view.dart', overwrite: true);

  @override
  String get content => '''
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../core/utils/utils.dart';
import '../controllers/authentication_controller.dart';
import '../widget/forgot_password_tab_widget.dart';

part '../widget/custom_prefix_icon_widget.dart';
part '../widget/sign_in_tab_widget.dart';
part '../widget/sign_up_tab_widget.dart';
part '../widget/social_icon_widget.dart';
part '../widget/wave_clipper.dart';
part '../widget/wave_draw_clippath_widget.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({Key? key}) : super(key: key);
  @override
  _AuthenticationViewState createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> with SingleTickerProviderStateMixin {
  late final AuthenticationController controller;
  late final TabController tabController;
  late final List<Tab> listTabBar;

  @override
  void initState() {
    // Printt.white("init AuthenticationView");
    listTabBar = [
      Tab(text: LocaleKeys.SignIn.tr),
      Tab(text: LocaleKeys.SignUp.tr),
      Tab(text: LocaleKeys.ForgotPassword.tr),
    ];
    tabController = TabController(length: listTabBar.length, vsync: this);
    //
    controller = Get.find<AuthenticationController>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = 10.0;
    return GestureDetector(
      onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(
          children: [
            // FractionallySizedBox(
            //   heightFactor: 0.5,
            //   child: Container(
            //     color: Theme.of(context).colorScheme.primary,
            //   ),
            // ),
            const WaveDrawClipPathWidget(title: 'Authenication'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(borderRadius), boxShadow: [
                      BoxShadow(
                        color: Colors.green.shade50,
                        offset: const Offset(5, 5),
                        blurRadius: 10,
                        // spreadRadius: 5,
                        // blurStyle: BlurStyle.normal,
                      )
                    ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(borderRadius),
                              topRight: Radius.circular(borderRadius),
                            ),
                          ),
                          child: TabBar(
                            // onTap: (index) {},
                            isScrollable: true,
                            controller: tabController,
                            indicatorColor: Colors.green,
                            indicatorSize: TabBarIndicatorSize.label,
                            //duong` vien`
                            // indicator: BoxDecoration(
                            //   color: ColorConstants.blue100,
                            //   borderRadius: BorderRadius.circular(100),
                            //   border: Border.all(color: ColorConstants.blue100),
                            // ),
                            labelColor: Theme.of(context).colorScheme.primary,
                            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                            unselectedLabelColor: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.5),
                            tabs: listTabBar,
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child: TabBarView(
                            controller: tabController,
                            children: const [
                              SignInTabWidget(),
                              SignUpTapWidget(),
                              ForgotPasswordTapWidget(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LocaleKeys.DoYouWantToTryIt.tr, style: const TextStyle(fontSize: 12)),
                      TextButton(
                        child: Text(LocaleKeys.TryNow.tr, style: const TextStyle(fontSize: 14)),
                        onPressed: () => controller.onTryApp(),
                      ),
                    ],
                  ),
                  const OrDivider(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SocialIcon(
                          colors: const [
                            Color(0xFF102397),
                            Color(0xFF187adf),
                            Color(0xFF00eaf8),
                          ],
                          iconURL: 'assets/svg/facebook.svg',
                          onPressed: () async {},
                        ),
                        SocialIcon(
                          colors: const [
                            Color(0xFF17ead9),
                            Color(0xFF6078ea),
                          ],
                          iconURL: 'assets/svg/twitter.svg',
                          onPressed: () {
                            print('twitter');
                          },
                        ),
                        SocialIcon(
                          colors: const [
                            Color(0xFFff4f38),
                            Color(0xFFff355d),
                          ],
                          iconURL: 'assets/svg/google-plus.svg',
                          onPressed: () async {},
                        ),
                        SocialIcon(
                          colors: const [
                            Color(0xFF00c6fb),
                            Color(0xFF005bea),
                          ],
                          iconURL: 'assets/svg/github.svg',
                          onPressed: () {
                            print('github');
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: size.width * 0.8,
      child: const Row(
        children: [
          Expanded(
            child: Divider(color: Colors.grey),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'OR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Divider(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
''';
}

class Wwww3qDatz_custom_prefix_icon_widget_Sample extends Sample {
  Wwww3qDatz_custom_prefix_icon_widget_Sample() : super('lib/app/modules/authentication/widget/custom_prefix_icon_widget.dart', overwrite: true);

  @override
  String get content => '''
part of '../views/authentication_view.dart';

class CustomPrefixIconWidget extends StatelessWidget {
  const CustomPrefixIconWidget({super.key, required this.color, required this.icon});

  final Color color;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(10.0))),
        child: icon);
  }
}
''';
}

class Wwww3qDatz_forgot_password_tab_widget_Sample extends Sample {
  Wwww3qDatz_forgot_password_tab_widget_Sample() : super('lib/app/modules/authentication/widget/forgot_password_tab_widget.dart', overwrite: true);

  @override
  String get content => '''
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '/app/modules/authentication/controllers/authentication_controller.dart';
import '/generated/locales.g.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../views/authentication_view.dart';

class ForgotPasswordTapWidget extends GetView<AuthenticationController> {
  const ForgotPasswordTapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formForgotPasswordKey,
      child: ListView(
        padding: const EdgeInsets.all(15.0),
        physics: const BouncingScrollPhysics(), //remove Glow effect
        children: <Widget>[
          FormBuilderTextField(
            name: 'email',
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              prefixIcon: CustomPrefixIconWidget(
                icon: SvgPicture.asset(
                  'assets/svg/google-plus.svg',
                  height: 20,
                  width: 20,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                color: Colors.red,
              ),
              // suffixIcon: Icon(
              //   Icons.check_circle,
              //   color: Colors.black26,
              // ),
              labelText: LocaleKeys.Email.tr,
              // hintStyle: const TextStyle(color: Colors.yellow),
              filled: true,
              fillColor: Colors.lightBlueAccent.withOpacity(0.1),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
          ),
          const SizedBox(height: 163.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: ElevatedButton(
              onPressed: () => controller.onForgotPassword(),
              child: const Text('OK'),
            ),
          ),
        ],
      ),
    );
  }
}
''';
}

class Wwww3qDatz_sign_in_tab_widget_Sample extends Sample {
  Wwww3qDatz_sign_in_tab_widget_Sample() : super('lib/app/modules/authentication/widget/sign_in_tab_widget.dart', overwrite: true);

  @override
  String get content => '''
part of '../views/authentication_view.dart';

class SignInTabWidget extends GetView<AuthenticationController> {
  const SignInTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formSignInKey,
      child: ListView(
        padding: const EdgeInsets.all(15.0),
        physics: const BouncingScrollPhysics(), //remove Glow effect
        children: <Widget>[
          ...buildTextField_UserNamePassWord(),
          const SizedBox(height: 15.0),
          StatefulBuilder(
              builder: (context, setState) => CheckboxListTile(
                    activeColor: Colors.green,
                    title: Text(LocaleKeys.RememberPassword.tr),
                    value: controller.isRememberPassword,
                    onChanged: (value) => setState(() => controller.isRememberPassword = value!),
                  )),
          const SizedBox(height: 15.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: ElevatedButton(
              onPressed: () => controller.onSignIn(),
              child: Text(LocaleKeys.SignIn.tr),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> buildTextField_UserNamePassWord() {
  bool isVisiblePassword = true;
  return [
    FormBuilderTextField(
      name: 'email',
      initialValue: 'email@gmail.com', //
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: CustomPrefixIconWidget(
          icon: const Icon(Icons.email, color: Colors.green),
          color: Colors.greenAccent.withOpacity(0.5),
        ),
        // suffixIcon: Icon(
        //   Icons.check_circle,
        //   color: Colors.black26,
        // ),
        labelText: LocaleKeys.Email.tr,
        // hintStyle: const TextStyle(color: Colors.yellow),
        filled: true,
        fillColor: Colors.lightBlueAccent.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
      ),
      // style: TextStyle(color: Theme.of(context).colorScheme.primary),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    ),
    const SizedBox(height: 15.0),
    StatefulBuilder(
        builder: (context, setState) => FormBuilderTextField(
              name: 'password',
              initialValue: 'password',
              obscureText: isVisiblePassword,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: CustomPrefixIconWidget(
                  icon: const Icon(Icons.key, color: Colors.pinkAccent),
                  color: Colors.yellowAccent.withOpacity(0.5),
                ),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => isVisiblePassword = !isVisiblePassword),
                  icon: Icon(
                    isVisiblePassword ? Icons.visibility : Icons.visibility_off,
                    size: 24.0,
                  ),
                ),
                labelText: LocaleKeys.Password.tr,
                // hintStyle: const TextStyle(color: Colors.yellow),
                filled: true,
                fillColor: Colors.lightBlueAccent.withOpacity(0.1),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            )),
  ];
}
''';
}

class Wwww3qDatz_sign_up_tab_widget_Sample extends Sample {
  Wwww3qDatz_sign_up_tab_widget_Sample() : super('lib/app/modules/authentication/widget/sign_up_tab_widget.dart', overwrite: true);

  @override
  String get content => '''
part of '../views/authentication_view.dart';

class SignUpTapWidget extends GetView<AuthenticationController> {
  const SignUpTapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formSignUpKey,
      child: ListView(
        padding: const EdgeInsets.all(15.0),
        physics: const BouncingScrollPhysics(), //remove Glow effect
        children: <Widget>[
          ...buildTextField_UserNamePassWord(),
          const SizedBox(height: 15.0),
          FormBuilderTextField(
            name: 'confirmPassword',
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              prefixIcon: CustomPrefixIconWidget(
                icon: const Icon(Icons.vpn_key, color: Colors.white),
                color: Colors.blueAccent.withOpacity(0.5),
              ),
              // suffixIcon: Icon(
              //   Icons.check_circle,
              //   color: Colors.black26,
              // ),
              labelText: LocaleKeys.ConfirmPassword.tr,
              // hintStyle: const TextStyle(color: Colors.yellow),
              filled: true,
              fillColor: Colors.lightBlueAccent.withOpacity(0.1),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          const SizedBox(height: 15.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: ElevatedButton(
              onPressed: () => controller.onSignUp(),
              child: Text(LocaleKeys.SignUp.tr),
            ),
          ),
        ],
      ),
    );
  }
}
''';
}

class Wwww3qDatz_social_icon_widget_Sample extends Sample {
  Wwww3qDatz_social_icon_widget_Sample() : super('lib/app/modules/authentication/widget/social_icon_widget.dart', overwrite: true);

  @override
  String get content => '''
part of '../views/authentication_view.dart';

class SocialIcon extends StatelessWidget {
  final List<Color> colors;
  final String iconURL;
  final void Function() onPressed;
  const SocialIcon({Key? key, required this.colors, required this.iconURL, required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: colors)),
      child: RawMaterialButton(
        shape: const CircleBorder(),
        onPressed: onPressed,
        child: SvgPicture.asset(
          iconURL,
          height: 20,
          width: 20,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}
''';
}

class Wwww3qDatz_wave_clipper_Sample extends Sample {
  Wwww3qDatz_wave_clipper_Sample() : super('lib/app/modules/authentication/widget/wave_clipper.dart', overwrite: true);

  @override
  String get content => '''
part of '../views/authentication_view.dart';

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
''';
}

class Wwww3qDatz_wave_draw_clippath_widget_Sample extends Sample {
  Wwww3qDatz_wave_draw_clippath_widget_Sample() : super('lib/app/modules/authentication/widget/wave_draw_clippath_widget.dart', overwrite: true);

  @override
  String get content => '''
part of '../views/authentication_view.dart';

class WaveDrawClipPathWidget extends StatelessWidget {
  const WaveDrawClipPathWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: WaveClipper2(),
          child: Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green.shade50, Colors.blue.shade50])),
          ),
        ),
        ClipPath(
          clipper: WaveClipper3(),
          child: Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green.shade100, Colors.blue.shade100])),
            child: const Column(),
          ),
        ),
        ClipPath(
          clipper: WaveClipper1(),
          child: Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green, Theme.of(context).colorScheme.primary])),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                const Icon(
                  Icons.fastfood,
                  color: Colors.white,
                  size: 60,
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.w700, fontSize: 30),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
''';
}
