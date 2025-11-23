import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:truee_balance_app/core/themes/app_colors.dart';
import 'package:truee_balance_app/core/themes/text_colors.dart';
import 'package:truee_balance_app/core/widgets/button/custom_button_widget.dart';
import 'package:truee_balance_app/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:truee_balance_app/features/auth/business_logic/auth_cubit.dart';
import 'package:truee_balance_app/features/user/home/presentation/screens/home_screen.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        } else if (state is LoginFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("loginFailedPleaseTryAgain".tr())),
          );
        }
      },
      child: Form(
        key: authCubit.formKey,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
          decoration: BoxDecoration(
            color: AppColors.neutralColor100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'email'.tr(),
                style: Styles.contentEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
              ),
              8.verticalSpace,
              CustomTextFormFieldWidget(
                controller: authCubit.emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'enterYourEmail'.tr(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'emailRequired'.tr();
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                      .hasMatch(value.trim())) {
                    return 'emailInvalid'.tr();
                  }
                  return null;
                },
                hintStyle: Styles.captionRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                borderColor: AppColors.neutralColor600,
              ),
              18.verticalSpace,
              Text(
                'password'.tr(),
                style: Styles.contentEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
              ),
              8.verticalSpace,
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previous, current) =>
                    current is TogglePasswordState,
                builder: (context, state) {
                  return CustomTextFormFieldWidget(
                    controller: authCubit.passwordController,
                    obscureText: authCubit.isObscure,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'enterYourPassword'.tr(),
                    hintStyle: Styles.captionRegular.copyWith(
                      color: AppColors.neutralColor600,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'passwordIsRequired'.tr();
                      }
                      return null;
                    },
                    borderColor: AppColors.neutralColor600,
                    suffixIcon: IconButton(
                      onPressed: authCubit.toggleObscure,
                      icon: Icon(
                        authCubit.isObscure ? Iconsax.eye : Iconsax.eye_slash,
                        color: AppColors.neutralColor600,
                      ),
                    ),
                  );
                },
              ),
              23.verticalSpace,
              CustomButtonWidget(
                text: 'login'.tr(),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                textStyle: Styles.captionEmphasis.copyWith(
                  color: AppColors.neutralColor100,
                ),
                onPressed: () {
                  if (authCubit.formKey.currentState!.validate()) {
                    authCubit.userLogin();
                  }
                },
              ),
              18.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'dontHaveAnAccount'.tr(),
                    style: Styles.captionEmphasis.copyWith(
                      color: AppColors.neutralColor300,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.only(
                        left: 6.w,
                        top: 18.w,
                        bottom: 18.w,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      foregroundColor: AppColors.primaryColor200,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'signUp'.tr(),
                          style: Styles.captionEmphasis.copyWith(
                            color: AppColors.primaryColor900,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5.w,
                            decorationColor: AppColors.primaryColor900,
                          ),
                        ),
                        Transform(
                          alignment: Alignment.center,
                          transform: context.locale.languageCode == "ar"
                              ? Matrix4.rotationY(3.1416)
                              : Matrix4.identity(),
                          child: SvgPicture.asset(
                            'assets/images/svg/sign_up_icon.svg',
                          ),
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
