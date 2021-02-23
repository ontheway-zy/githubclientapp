
import 'package:flutter/material.dart';
import 'package:githubclientapp/common/global.dart';
import 'package:githubclientapp/l10n/localization_intl.dart';
import 'package:provider/provider.dart';

///选择皮肤
class ThemeChangeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var themeModel = Provider.of<ThemeModel>(context);

    return Scaffold(

      appBar: AppBar(title: Text(GmLocalizations.of(context).theme),),
      body: ListView(
        children: Global.themes.map<Widget>((e){
          return GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Container(color: e, height: 40,),
            ),
            onTap: (){
//              Provider.of<ThemeModel>(context, listen: false).theme = e;
              themeModel.theme = e;
            },
          );
        }).toList(),
      ),
    );
  }

}
