// extends from MainModule
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mubrm_tag/pages/active_mubrm_tag.dart';
import 'package:mubrm_tag/pages/active_mini_mubrm_tag.dart';
import 'package:mubrm_tag/pages/edit_profile_page.dart';
import 'package:mubrm_tag/pages/forget_page.dart';
import 'package:mubrm_tag/pages/home_page.dart';
import 'package:mubrm_tag/pages/login_page.dart';
import 'package:mubrm_tag/pages/sing_up_page.dart';
import 'package:mubrm_tag/pages/splash_page.dart';

import 'app_widget.dart';


class AppModule extends MainModule {
  // here will be any class you want to inject into your project (eg bloc, dependency)
  @override
  List<Bind> get binds => [];

  // here will be the routes of your module
  @override
  List<ModularRouter> get routers => [
    ModularRouter("/",
            child: (_, args) => SplashPage(), transition: TransitionType.fadeIn),
    ModularRouter("/login",
            child: (_, args) => LoginPage(), transition: TransitionType.fadeIn),
    ModularRouter("/sing_up",
            child: (_, args) => SingUpPage(), transition: TransitionType.fadeIn),
    ModularRouter("/edit_page",
            child: (_, args) => EditProfilePage(), transition: TransitionType.fadeIn),
    ModularRouter("/home_page",
            child: (_, args) => HomePage(), transition: TransitionType.fadeIn),
    ModularRouter("/forget_password_page",
            child: (_, args) => ForgetPasswordPage(), transition: TransitionType.fadeIn),
    ModularRouter("/active_page",
            child: (_, args) => ActivePage(), transition: TransitionType.fadeIn),
    ModularRouter("/active_page_phone",
            child: (_, args) => ActivePagePhone(), transition: TransitionType.fadeIn),
      ];

// add your main widget here
  @override
  Widget get bootstrap => AppWidget();

}
