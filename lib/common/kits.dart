
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///头像
Widget gmAvatar(String url, {
  double width = 30,
  double height,
  BoxFit fit,
  BorderRadius borderRadius,
}) {
  var placeholder = Image.asset(
      "images/avatar-default.png", //头像占位图，加载过程中显示
      width: width,
      height: height
  );
  return ClipRRect(
    borderRadius: borderRadius ?? BorderRadius.circular(2),
    child: CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>placeholder,
      errorWidget: (context, url, error) =>placeholder,
    ),
  );
}


///Loading框
showLoadingDialog(BuildContext context) {

  showDialog(
    context: context,
    barrierDismissible: true, //点击遮罩不关闭对话框
    builder: (context) {
      /*return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("正在加载，请稍后..."),
              )
            ],
          ),
        );*/

      ///showDialog中已经给对话框设置了宽度限制
      ///自定义宽度 可以使用UnconstrainedBox先抵消showDialog对宽度的限制，然后再使用SizedBox指定宽度
      return UnconstrainedBox(
        constrainedAxis: Axis.vertical,
        child: SizedBox(
          width: 280,
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(top: 26.0),
                  child: Text("正在加载，请稍后..."),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

///Toast String
void showToast(String msg){

  Fluttertoast.showToast(msg: msg);
}
