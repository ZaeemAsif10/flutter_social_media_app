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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwrodController = TextEditingController();
  final AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: authenticationController.isLoading.value,
          color: AppColor.grey,
          progressIndicator: const CircularProgressIndicator(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Form(
                  key: authenticationController.formstate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HeadingText(headingText: "Register"),
                      const SizedBox(height: 30),
                      InputWidget(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Name";
                          }
                        },
                        hintText: "Name",
                        controller: _nameController,
                        obsecureText: false,
                      ),
                      const SizedBox(height: 10),
                      InputWidget(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Username";
                          }
                        },
                        hintText: "Username",
                        controller: _usernameController,
                        obsecureText: false,
                      ),
                      const SizedBox(height: 10),
                      InputWidget(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Email";
                          }
                        },
                        hintText: "Email",
                        controller: _emailController,
                        obsecureText: false,
                      ),
                      const SizedBox(height: 10),
                      InputWidget(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return "Password more then 6";
                          }
                        },
                        hintText: "Password",
                        controller: _passwrodController,
                        obsecureText: true,
                      ),
                      CutomButton(
                        onPressed: () async {
                          await authenticationController.register(
                            name: _nameController.text.trim(),
                            username: _usernameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwrodController.text.trim(),
                          );
                        },
                        text: "Register",
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offNamed(AppRoute.login);
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(fontSize: size * 0.040),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
