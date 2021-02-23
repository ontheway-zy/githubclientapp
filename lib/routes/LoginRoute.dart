
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:githubclientapp/common/global.dart';
import 'package:githubclientapp/common/kits.dart';
import 'package:githubclientapp/http/http.dart';
import 'package:githubclientapp/l10n/localization_intl.dart';
import 'package:githubclientapp/models/index.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return _LoginRouteState();
  }

}

class _LoginRouteState extends State<LoginRoute> {

  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pswController = new TextEditingController();

  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;
  bool pwdShow = false; //密码是否显示明文

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin;
    if (_unameController.text.isNotEmpty) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var gm = GmLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(gm.login),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
//          autovalidate: true, //开启自动校验 已弃用 autovalidateMode代替
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _unameController,
                decoration: InputDecoration(
                  labelText: gm.userName,
                  hintText: gm.userNameOrEmail,
                  prefixIcon: Icon(Icons.person),
                ),

                // 校验用户名（不能为空）
                validator: (v){
                  return v.trim().isNotEmpty ? null : gm.userNameRequired;
                },
              ),

              TextFormField(
                autofocus: !_nameAutoFocus,
                controller: _pswController,
                decoration: InputDecoration(
                  labelText: gm.password,
                  hintText: gm.password,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      icon: Icon(pwdShow ? Icons.visibility_off : Icons.visibility),
                      onPressed: (){
                        setState(() {
                          pwdShow = !pwdShow;
                        });
                      }),
                ),
                obscureText: !pwdShow,

                //校验密码（不能为空）
                validator: (v){
                  return v.trim().isNotEmpty ? null : gm.passwordRequired;
                },
              ),

              Padding(
                padding: EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text(gm.login),
                    onPressed: _onLogin,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async {

    if((_formKey.currentState as FormState).validate()){
      showLoadingDialog(context);

      User user;

      try {
        user = await Git().login(_unameController.text, _pswController.text);
        // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        print(e);

        //登录失败则提示
        if (e.response?.statusCode == 401) {
          showToast(GmLocalizations.of(context).userNameOrPasswordWrong);
        } else {
          showToast(e.toString());
        }

      } finally {
        // 隐藏loading框
        Navigator.of(context).pop();
      }

      //登陆成功够返回首页
      if (user != null){
        Navigator.of(context).pop();
      }
    }


  }

}