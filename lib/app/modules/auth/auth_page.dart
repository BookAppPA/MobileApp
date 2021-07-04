import 'package:book_app/app/modules/auth/auth_controller.dart';
import 'package:book_app/app/modules/widgets_global/button_arround.dart';
import 'package:book_app/app/modules/widgets_global/mytextfield.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:book_app/app/utils/constant/constant_image.dart';
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
            // height: Get.height,
            padding: EdgeInsets.all(22),
            child: GetBuilder<AuthController>(
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: Get.width,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 30),
                        Container(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            ConstantImage.logo,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          controller.authView == AuthView.LOGIN
                              ? AppTranslation.welcome.tr
                              : AppTranslation.welcomeBack.tr,
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
                  SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      controller.authView == AuthView.LOGIN
                          ? Container()
                          : MyTextfield(
                              controller: controller.pseudoController,
                              width: double.maxFinite,
                              height: 75,
                              accentColor: Colors.white, // On Focus Color
                              textColor: controller.isPseudoValid
                                  ? Color(0xff3C3C43)
                                  : Colors.red, //Text Color
                              backgroundColor:
                                  Color(0xffE8E8E8), //Not Focused Color
                              borderColor: controller.isPseudoValid
                                  ? Colors.grey
                                  : Colors.red,
                              textBaseline: TextBaseline.alphabetic,
                              autocorrect: true,
                              fontFamily: 'Righteous', //Text Fontfamily
                              maxLines: 1,
                              wordSpacing: 2,
                              margin: EdgeInsets.symmetric(vertical: 0),
                              inputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                              placeholder:
                                  controller.authView == AuthView.SIGNUP
                                      ? AppTranslation.enterPseudo.tr
                                      : AppTranslation.enterNameOfBookStore.tr,
                              prefixIcon: Icon(FontAwesomeIcons.user, size: 20),
                              prefixIconColor: controller.isPseudoValid
                                  ? Color(0x993C3C43)
                                  : Colors.redAccent,
                            ),
                      MyTextfield(
                        controller: controller.emailController,
                        width: double.maxFinite,
                        height: 75,
                        accentColor: Colors.white, // On Focus Color
                        textColor: controller.isEmailValid
                            ? Color(0xff3C3C43)
                            : Colors.red,
                        backgroundColor: Color(0xffE8E8E8), //Not Focused Color
                        borderColor:
                            controller.isEmailValid ? Colors.grey : Colors.red,
                        textBaseline: TextBaseline.alphabetic,
                        autocorrect: true,
                        fontFamily: 'Righteous', //Text Fontfamily
                        maxLines: 1,
                        wordSpacing: 2,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        placeholder: AppTranslation.enterEmail.tr,
                        prefixIcon: Icon(Icons.email_outlined),
                        prefixIconColor: controller.isEmailValid
                            ? Color(0x993C3C43)
                            : Colors.redAccent,
                      ),
                      MyTextfield(
                        controller: controller.passwordController,
                        width: double.maxFinite,
                        height: 75,
                        accentColor: Colors.white, // On Focus Color
                        textColor: controller.isPasswordValid
                            ? Color(0xff3C3C43)
                            : Colors.red,
                        backgroundColor: Color(0xffE8E8E8), //Not Focused Color
                        borderColor: controller.isPasswordValid
                            ? Colors.grey
                            : Colors.red,
                        textBaseline: TextBaseline.alphabetic,
                        fontFamily: 'Righteous', //Text Fontfamily
                        maxLines: 1,
                        wordSpacing: 2,
                        margin: EdgeInsets.symmetric(
                            vertical:
                                controller.authView == AuthView.LOGIN ? 10 : 0),
                        duration: Duration(milliseconds: 300),
                        inputType: TextInputType.visiblePassword,
                        placeholder: AppTranslation.enterPassword.tr,
                        obscureText: true,
                        prefixIcon: Icon(Icons.lock_outline),
                        prefixIconColor: controller.isPasswordValid
                            ? Color(0x993C3C43)
                            : Colors.redAccent,
                        suffixIcon: Icon(Icons.remove_red_eye),
                      ),
                      controller.authView == AuthView.PRO
                          ? MyTextfield(
                              controller: controller.siretController,
                              width: double.maxFinite,
                              height: 75,
                              accentColor: Colors.white, // On Focus Color
                              textColor: controller.isSiretValid
                                  ? Color(0xff3C3C43)
                                  : Colors.red,
                              backgroundColor:
                                  Color(0xffE8E8E8), //Not Focused Color
                              borderColor: controller.isSiretValid
                                  ? Colors.grey
                                  : Colors.red,
                              textBaseline: TextBaseline.alphabetic,
                              autocorrect: false,
                              fontFamily: 'Righteous', //Text Fontfamily
                              maxLines: 1,
                              wordSpacing: 2,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              inputType: TextInputType.number,
                              inputAction: TextInputAction.done,
                              placeholder: AppTranslation.sirenOrSiretNumber.tr,
                              prefixIcon: Icon(FontAwesomeIcons.building),
                              prefixIconColor: controller.isSiretValid
                                  ? Color(0x993C3C43)
                                  : Colors.redAccent,
                            )
                          : Container(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          controller.authView == AuthView.LOGIN
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
                                        text: AppTranslation
                                            .termConditionBegin.tr,
                                      ),
                                      TextSpan(
                                        text: AppTranslation
                                            .termConditionMiddle.tr,
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            AppTranslation.termConditionEnd.tr,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                          SizedBox(height: 10),
                          ButtonArround(
                            onTap: () => controller.submitAuth(),
                            width: Get.width,
                            borderRadius: 10,
                            isLoading: controller.isLoading,
                            text: controller.authView == AuthView.LOGIN
                                ? AppTranslation.login.tr
                                : AppTranslation.signup.tr,
                          ),
                          SizedBox(height: 10),
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
                                        text: controller.authView ==
                                                AuthView.LOGIN
                                            ? AppTranslation.newQuestion.tr
                                            : AppTranslation
                                                .alreadySignupQuestion.tr,
                                      ),
                                      TextSpan(
                                        text: controller.authView ==
                                                AuthView.LOGIN
                                            ? AppTranslation.login.tr
                                            : AppTranslation.signup.tr,
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
                          SizedBox(height: 10),
                          controller.authView == AuthView.LOGIN
                              ? GestureDetector(
                                  onTap: () =>
                                      controller.changeAuthViewToProAccount(),
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
                                              text: AppTranslation.areYouBookSeller.tr,
                                            ),
                                            TextSpan(
                                              text: AppTranslation.createProAccount.tr,
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
                                )
                              : Container(),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
