import 'package:book_app/app/modules/auth/auth_controller.dart';
import 'package:book_app/app/modules/widgets_global/button_arround.dart';
import 'package:book_app/app/modules/widgets_global/mytextfield.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
                    child: Container(
            width: Get.width,
            height: Get.height,
            padding: EdgeInsets.all(22),
            child: GetBuilder<AuthController>(
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: controller.isLoginView ? 1 : 2,
                    child: Container(
                      width: Get.width,
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          FlutterLogo(size: 100),
                          SizedBox(height: 20),
                          Text(
                            controller.isLoginView
                                ? "Hey, \nheureux de te revoir !"
                                : "Hey, tu es nouveau ?",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 28,
                              color: Color(0xff5aaabd),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: controller.isLoginView ? 1 : 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        controller.isLoginView ? Container() :
                        MyTextfield(
                          controller: controller.pseudoController,
                          width: double.maxFinite,
                          height: 75,
                          accentColor: Colors.white, // On Focus Color
                          textColor: controller.isPseudoValid ? Color(0xff3C3C43) : Colors.red, //Text Color
                          backgroundColor:
                              Color(0xffE8E8E8), //Not Focused Color
                          borderColor: controller.isPseudoValid ? Colors.grey : Colors.red,
                          textBaseline: TextBaseline.alphabetic,
                          autocorrect: true,
                          fontFamily: 'Righteous', //Text Fontfamily
                          maxLines: 1,
                          wordSpacing: 2,
                          margin: EdgeInsets.symmetric(vertical: 0),
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          placeholder: "Saisissez votre pseudo",
                          prefixIcon: Icon(FontAwesomeIcons.userAlt, size: 20),
                          prefixIconColor: controller.isPseudoValid ? Color(0x993C3C43) : Colors.redAccent,
                        ),
                        MyTextfield(
                          controller: controller.emailController,
                          width: double.maxFinite,
                          height: 75,
                          accentColor: Colors.white, // On Focus Color
                          textColor: controller.isEmailValid ? Color(0xff3C3C43) : Colors.red,
                          backgroundColor:
                              Color(0xffE8E8E8), //Not Focused Color
                          borderColor: controller.isEmailValid ? Colors.grey : Colors.red,
                          textBaseline: TextBaseline.alphabetic,
                          autocorrect: true,
                          fontFamily: 'Righteous', //Text Fontfamily
                          maxLines: 1,
                          wordSpacing: 2,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          placeholder: "Saisissez une adresse email",
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: controller.isEmailValid ? Color(0x993C3C43) : Colors.redAccent,
                        ),
                        MyTextfield(
                          controller: controller.passwordController,
                          width: double.maxFinite,
                          height: 75,
                          accentColor: Colors.white, // On Focus Color
                          textColor: controller.isPasswordValid ? Color(0xff3C3C43) : Colors.red,
                          backgroundColor:
                              Color(0xffE8E8E8), //Not Focused Color
                          borderColor: controller.isPasswordValid ? Colors.grey : Colors.red,
                          textBaseline: TextBaseline.alphabetic,
                          fontFamily: 'Righteous', //Text Fontfamily
                          maxLines: 1,
                          wordSpacing: 2,
                          margin: EdgeInsets.symmetric(vertical: controller.isLoginView ? 10 : 0),
                          duration: Duration(milliseconds: 300),
                          inputType: TextInputType.visiblePassword,
                          placeholder: "Saisissez un mot de passe",
                          obscureText: true,
                          prefixIcon: Icon(Icons.lock_outline),
                          prefixIconColor: controller.isPasswordValid ? Color(0x993C3C43) : Colors.redAccent,
                          suffixIcon: Icon(Icons.remove_red_eye),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: controller.isLoginView ? 1 : 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        controller.isLoginView
                            ? Container()
                            : Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Text',
                                    fontSize: 13,
                                    color: Color(0x993c3c43),
                                    height: 1.5,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          'En créant un compte, vous acceptez les ',
                                    ),
                                    TextSpan(
                                      text:
                                          'conditions générales d\'utilisation',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' de BookApp.',
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              ),
                        ButtonArround(
                          onTap: () => controller.submitAuth(),
                          text: controller.isLoginView
                              ? "Se connecter"
                              : "S'inscrire",
                        ),
                        GestureDetector(
                          onTap: () => controller.changeAuthMode(),
                          child: Container(
                            height: 30,
                            color: Colors.transparent,
                            child: Center(
                              child: Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Text',
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: controller.isLoginView
                                          ? "Nouveau ? "
                                          : "Déjà inscrit ? ",
                                    ),
                                    TextSpan(
                                      text: controller.isLoginView
                                          ? "S'inscrire"
                                          : "Se connecter",
                                      style: TextStyle(
                                        color: Color(0xff5aaabd),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
