import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:githubclientapp/common/global.dart';
import 'package:githubclientapp/routes/HomeRoute.dart';
import 'package:githubclientapp/routes/LanguageRoute.dart';
import 'package:githubclientapp/routes/LoginRoute.dart';
import 'package:githubclientapp/routes/ThemeChangeRoute.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'l10n/localization_intl.dart';


//void main() => runApp(MyApp());
//If you're running an application and need to access the binary messenger before `runApp()` has been called (for example, during plugin initialization), then you need to explicitly call the `WidgetsFlutterBinding.ensureInitialized()` first.
void main() => Global.init().then((e)=> runApp(MyApp())); //先初始化

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (BuildContext context, themeModel, localeModel, Widget child) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: themeModel.theme,
            ),
            onGenerateTitle: (context){
              // 此时context在Localizations的子树
              return GmLocalizations.of(context).title;
            },
            //title: GmLocalizations.of(context).title, //不能正常工作！

            home: HomeRoute(), //应用主页
            locale: localeModel.getLocale(),
            //我们只支持美国英语和中文简体
            supportedLocales: [
              const Locale('en', 'US'), // 美国英语
              const Locale('zh', 'CN'), // 中文简体
              //其它Locales
            ],
            localizationsDelegates: [
              // 本地化的代理类
              GlobalMaterialLocalizations.delegate, //Material 组件库提供的本地化的字符串和其他值
              GlobalWidgetsLocalizations.delegate, //定义组件默认的文本方向
              GmLocalizationsDelegate() // 注册我们自定义的Delegate
            ],
            localeResolutionCallback:
                (Locale _locale, Iterable<Locale> supportedLocales) {
              if (localeModel.getLocale() != null) {
                //如果已经选定语言，则不跟随系统
                return localeModel.getLocale();
              } else {

                Locale locale;
                //APP语言跟随系统语言，如果系统语言不是中文简体或美国英语，
                //则默认使用美国英语
                if (supportedLocales.contains(_locale)) {
                  locale= _locale;
                } else {
                  locale= Locale('en', 'US');
                }
                return locale;
              }
            },
            // 注册命名路由表
            routes: <String, WidgetBuilder>{
              "login": (context) => LoginRoute(),
              "themes": (context) => ThemeChangeRoute(),
              "language": (context) => LanguageRoute(),
            },
          );
        },
      ),
    );
  }
}
