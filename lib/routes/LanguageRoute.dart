import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:githubclientapp/common/global.dart';
import 'package:githubclientapp/l10n/localization_intl.dart';
import 'package:provider/provider.dart';

///选择语言
class LanguageRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    var localeModel = Provider.of<LocaleModel>(context);
    var gm = GmLocalizations.of(context);

    ///在build(…)方法里面定义了_buildLanguageItem(…)方法，它和在LanguageRoute类中定义该方法的区别就在于：在build(…)内定义的方法可以共享build(...)方法上下文中的变量，本例中是共享了localeModel.(复杂一些的话不建议这样做)
    //构建语言选择项
    Widget _buildLanguageItem(String lan, value) {
      return ListTile(
        title: Text(
          lan,
          // 对APP当前语言进行高亮显示
          style: TextStyle(color: localeModel.locale == value ? color : null),
        ),
        trailing:
        localeModel.locale == value ? Icon(Icons.done, color: color) : null,
        onTap: () {
          // 更新locale后MaterialApp会重新build
          localeModel.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(gm.language),
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem("中文简体", "zh_CN"),
          _buildLanguageItem("English", "en_US"),
          _buildLanguageItem(gm.auto, null),
        ],
      ),
    );
  }
}