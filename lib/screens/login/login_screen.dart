import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms_app/helper/colors.dart';
import 'package:vms_app/widget/box_edittext.dart';

import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.focusScope?.unfocus();
                },
                child: SizedBox(
                  width: Get.width,
                  height: Get.height * 0.3,
                  child: Image.asset('assets/visit.png',),
                ),
              ),
              Container(
                height: Get.height*0.5,
                transform: Matrix4.translationValues(0, -16, 0),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    const Text(
                      'Welcome back!',
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    BoxEditText(
                      placeholder: 'User Name',
                      controller: controller.userNameController,
                      prefixIcon: const Icon(
                        Icons.person,
                        size: 18,

                      ),
                      maxLines: 1,
                      // maxLength: 10,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => BoxEditText(
                        placeholder: 'Password',
                        controller: controller.passwordController,
                        // maxLength: 4,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 18,
                                                  ),
                        suffixIcon: InkWell(
                          onTap: () => controller.passwordToggle(),
                          child: Icon(
                            controller.passwordIcon.value,
                            size: 18,

                          ),
                        ),
                        maxLines: 1,
                        obsecureText: controller.isSecure.value,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: [
                        const SizedBox(width: 8,),
                        Row(
                          children: [
                            SizedBox(
                              width: 18,
                              child: Obx(
                                () => Theme(
                                  data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: Colors.white),
                                  child: Checkbox(
                                    value: controller.isRememberMe.value,
                                    activeColor: Colors.white,
                                    checkColor: primary,
                                    onChanged: (val) {
                                      controller.isRememberMe(val);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.isRememberMe(
                                    !controller.isRememberMe.value);
                              },
                              child: const Text(
                                'Remember me',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.forgetMpin();
                              },
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),*/
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'LOG IN',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Obx(
                          () => InkWell(
                            onTap: controller.isLoginLoading.value
                                ? null
                                : () => controller.login(),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.isLoginLoading.value
                                    ? primaryDark
                                    : Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.white, blurRadius: 0.5),
                                  BoxShadow(
                                      color: Colors.grey, blurRadius: 0.5),
                                  BoxShadow(color: primary, blurRadius: 0.5)
                                ],
                              ),
                              child: controller.isLoginLoading.value
                                  ? const CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          primaryDark),
                                    )
                                  : const Icon(
                                      Icons.arrow_forward,
                                      color: primary,
                                    ),
                            ),
                          ),
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
    );
  }
}
