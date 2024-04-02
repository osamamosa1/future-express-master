import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/utils/user_local.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../shared/utils/assets_manager.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      var cubit = AppCubit.get(context);
      PersistentTabController controller;
      controller = PersistentTabController(initialIndex: 2);
      List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
          PersistentBottomNavBarItem(
            icon: Image.asset(
              ImgAssets.orders,
            ),
            title: (context.tr.orders),
            activeColorPrimary: Palette.primaryColor,
            inactiveColorPrimary: Palette.greyColor,
          ),
          PersistentBottomNavBarItem(
            icon: Image.asset(
              ImgAssets.wallet,
              color: Palette.greyColor,
            ),
            title: (context.tr.wallet),
            activeColorPrimary: Palette.primaryColor,
            inactiveColorPrimary: Palette.greyColor,
          ),
          PersistentBottomNavBarItem(
            icon: Image.asset(
              ImgAssets.logo,
              width: 90.w,
            ),
            title: (' '),
            activeColorPrimary: Colors.white,
            inactiveColorPrimary: Palette.greyColor,
          ),
          PersistentBottomNavBarItem(
            icon: Image.asset(
              ImgAssets.support,
            ),
            title: (context.tr.technical_support),
            activeColorPrimary: Palette.primaryColor,
            inactiveColorPrimary: Palette.greyColor,
          ),
          PersistentBottomNavBarItem(
              icon: Image.asset(
                ImgAssets.profile,
              ),
              title: (context.tr.profile),
              activeColorPrimary: Palette.primaryColor,
              inactiveColorPrimary: Palette.greyColor),
        ];
      }

      log(controller.index.toString());
      return PersistentTabView(
        context,
        controller: controller,
        screens: UserLocal.userType == 1
            // CacheHelper.getData(key: 'user') == 1
            ? cubit.bottomScreens
            : cubit.bottomScreensRestaurnt,
        items: _navBarsItems(),
        navBarHeight: 80,
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style15, // Choose the nav bar style with this property.
      );
    });
  }
}
