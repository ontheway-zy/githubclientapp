
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart'; //1

/// 国际化
/// 1、集成依赖int1包
/// 2、创建l10n-arb目录，用来存放通过intl_translation命令生成的arb文件
/// 3、实现Localizations和Delegate类
/// 4、添加需要国际化的属性 如title
/// 5、生成arb文件 flutter pub pub run intl_translation:extract_to_arb --output-dir=l10n-arb \lib/l10n/localization_intl.dart
/// 6、创建一个"intl_zh_CN.arb"文件，然后将生成的"intl_messages.arb"的内容拷贝到"intl_zh_CN.arb"文件，接下来将英文翻译为中文即可
/// 7、根据arb生成dart文件 flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/localization_intl.dart l10n-arb/intl_*.arb

/// 执行命令的部分可以封装成一个shell脚本intl.sh 授权chmod +x intl.sh 执行./intl.sh

//如果某个特定的arb中缺失某个属性，那么应用将会加载默认的arb文件(intl_messages.arb)中的相应属性，这是Intl的托底策略。
//每次运行提取命令时，intl_messages.arb都会根据代码重新生成，但其他arb文件不会，所以当要添加新的字段或方法时，其他arb文件是增量的，不用担心会覆盖。
//arb文件是标准的，其格式规范可以自行了解。通常会将arb文件交给翻译人员，当他们完成翻译后，我们再通过下面的步骤根据arb文件生成最终的dart代码。

class GmLocalizations {
  static Future<GmLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    //2
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new GmLocalizations();
    });
  }

  static GmLocalizations of(BuildContext context) {
    return Localizations.of<GmLocalizations>(context, GmLocalizations);
  }

  String get title {
    return Intl.message(
      'Flutter APP Title',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }

  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: 'Title for the Demo application',
    );
  }
  String get login {
    return Intl.message(
      'Login',
    );
  }
  String get noDescription {
    return Intl.message(
      'Flutter APP',
      name: 'noDescription',
    );
  }
  String get theme {
    return Intl.message(
      'theme',
      name: 'theme',
    );
  }
  String get language {
    return Intl.message(
      'language',
      name: 'language',
    );
  }
  String get logout {
    return Intl.message(
      'logout',
      name: 'logout',
    );
  }
  String get logoutTip {
    return Intl.message(
      'logoutTip',
      name: 'logoutTip',
    );
  }
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
    );
  }
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
    );
  }
  String get userName {
    return Intl.message(
      'userName',
    );
  }
  String get userNameOrEmail {
    return Intl.message(
      'userNameOrEmail',
    );
  }
  String get password {
    return Intl.message(
      'password',
    );
  }
  String get userNameRequired {
    return Intl.message(
      'userNameRequired',
    );
  }
  String get passwordRequired {
    return Intl.message(
      'passwordRequired',
    );
  }
  String get userNameOrPasswordWrong {
    return Intl.message(
      'userNameOrPasswordWrong',
    );
  }
  String get auto {
    return Intl.message(
      'auto',
    );
  }

  //Intl.plural例子 未读邮件数
  remainingEmailsMessage(int howMany) => Intl.plural(howMany,
      zero: 'There are no emails left',
      one: 'There is $howMany email left',
      other: 'There are $howMany emails left',
      name: "remainingEmailsMessage",
      args: [howMany],
      desc: "How many emails remain after archiving.",
      examples: const {'howMany': 42, 'userName': 'Fred'});
}

//Locale代理类
class GmLocalizationsDelegate extends LocalizationsDelegate<GmLocalizations> {
  const GmLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<GmLocalizations> load(Locale locale) {
    //3
    return  GmLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(GmLocalizationsDelegate old) => false;
}