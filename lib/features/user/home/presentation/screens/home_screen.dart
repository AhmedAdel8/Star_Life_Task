import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truee_balance_app/core/cache_helper/cache_helper.dart';
import 'package:truee_balance_app/core/cache_helper/cache_keys.dart';
import 'package:truee_balance_app/core/themes/app_colors.dart';
import 'package:truee_balance_app/core/widgets/app_bar/custom_main_app_bar_in_home_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = CacheHelper.getData(key: CacheKeys.userName) ?? "";
    final userEmail = CacheHelper.getData(key: CacheKeys.userEmail) ?? "";
    final userImage = CacheHelper.getData(key: CacheKeys.userImage) ?? "";

    final users = [
      {
        "name": userName,
        "email": userEmail,
        "image": userImage,
      },
      {
        "name": userName,
        "email": userEmail,
        "image": userImage,
      },
      {
        "name": userName,
        "email": userEmail,
        "image": userImage,
      },
      {
        "name": userName,
        "email": userEmail,
        "image": userImage,
      },
      {
        "name": userName,
        "email": userEmail,
        "image": userImage,
      },
      {
        "name": userName,
        "email": userEmail,
        "image": userImage,
      },
      {
        "name": userName,
        "email": userEmail,
        "image": userImage,
      },
      {
        "name": userName,
        "email": userEmail,
        "image": userImage,
      },
      {
        "name": userName,
        "email": userEmail,
        "image": userImage,
      },
      {
        "name": userName,
        "email": userEmail,
        "image": userImage,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.primaryColor900,
      appBar: CustomMainAppBarInHomeWidget(
        userName: userName,
        location: 'myAddressHere'.tr(),
        profileImageAsset: userImage,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey[300],
                  height: 1.h,
                ),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                    leading: CircleAvatar(
                      radius: 25.r,
                      backgroundImage: user['image'] != null &&
                              user['image']!.isNotEmpty
                          ? NetworkImage(user['image']!)
                          : const AssetImage('assets/images/default_user.png')
                              as ImageProvider,
                    ),
                    title: Text(user['name'] ?? ""),
                    subtitle: Text(user['email'] ?? ""),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
