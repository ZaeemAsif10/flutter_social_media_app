import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:social_media_app/controllers/authentication.dart';
import 'package:social_media_app/route/app_route.dart';
import 'package:social_media_app/views/colors/color.dart';
import 'package:social_media_app/views/widgets/heading_text.dart';
import 'package:social_media_app/views/widgets/input_widget.dart';
import 'package:social_media_app/views/widgets/login_button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwrodController = TextEditingController();
  final AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Obx(() {
        return LoadingOverlay(
          isLoading: authenticationController.isLoading.value,
          color: AppColor.grey,
          progressIndicator: const CircularProgressIndicator(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const HeadingText(headingText: "Login"),
                    const SizedBox(height: 30),
                    InputWidget(
                      hintText: "Email",
                      controller: _emailController,
                      obsecureText: false,
                    ),
                    const SizedBox(height: 10),
                    InputWidget(
                      hintText: "Password",
                      controller: _passwrodController,
                      obsecureText: true,
                    ),
                    CutomButton(
                        onPressed: () async {
                          authenticationController.login(
                            email: _emailController.text.trim(),
                            password: _passwrodController.text.trim(),
                          );
                        },
                        text: "Login"),
                    TextButton(
                      onPressed: () {
                        Get.offNamed(AppRoute.register);
                      },
                      child: Text(
                        "Register",
                        style: GoogleFonts.poppins(fontSize: size * 0.040),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
