import 'dart:async';
import "dart:convert" show utf8;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart' as Model;
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/generated/l10n.dart';
import 'package:mubrm_tag/models/app_model.dart';
import 'package:mubrm_tag/models/user_model.dart';
import 'package:mubrm_tag/services/index.dart';
import 'package:mubrm_tag/web/web_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppWidget();
  }
}

class _AppWidget extends State<AppWidget> with WidgetsBindingObserver {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> loggedIn;
  final _userModel = UserModel();
  final _myApp = ModelApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ModelApp>.value(
      value: _myApp,
      child: Consumer<ModelApp>(
        builder: (context, value, child) {
          return MultiProvider(
            providers: [
              Provider<UserModel>.value(value: _userModel),
              Provider<ModelApp>.value(value: _myApp)
            ],
            child: MaterialApp(
              navigatorKey: Model.Modular.navigatorKey,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: Locale(Provider.of<ModelApp>(context).locale, ''),
              supportedLocales: S.delegate.supportedLocales,
              debugShowCheckedModeBanner: true,
              onGenerateRoute: (settings) {
                Uri uri = Uri.dataFromString(settings.name);
                String path = uri.path.substring(2);
                List<int> bytes = utf8.encode(path);
                String body = utf8.decode(bytes);
                Map<String,dynamic> data= {'url':body};
                print(data);

                switch (uri.path) {
                  case ',/':
                    {
                      if (kIsWeb) {
                        String param1 = uri.queryParameters['account_id'] ?? null;
                        return MaterialPageRoute(builder: (ccc) {
                          return WebPage(
                            accountId: param1,
                          );
                        });
                      } else {
                        return Model.Modular.generateRoute(settings);
                      }
                    }
                    break;
                  default:
                    {
                      if (kIsWeb) {
                        return MaterialPageRoute(builder: (ccc) {
                          return WebPage(
                            accountId: path,
                          );
                        });
                      } else {
                        return Model.Modular.generateRoute(settings);
                      }
                    }
                }
              },
              theme: themeData,
              title: 'Mubrm Tag',
              builder: (BuildContext context, Widget child) {
                return Directionality(
                  textDirection: Provider.of<ModelApp>(context).textDecoration,
                  child: _applyTextScaleFactor(child),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    Services().setAppConfig();
    printLog('initState', 'AppWidget');
    loggedIn = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool('loggedIn') ?? false);
    });
    super.initState();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  void dispose() {
    printLog('dispose', 'AppWidget');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget _applyTextScaleFactor(Widget child) {
    return Builder(
      builder: (BuildContext context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: false,
            textScaleFactor: 1.0,
          ),
          child: child,
        );
      },
    );
  }


}
