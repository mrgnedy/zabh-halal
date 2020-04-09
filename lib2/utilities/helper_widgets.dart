import 'package:flutter/material.dart';
import 'package:loading/indicator.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:zabh_halal/utilities/colors.dart';

class LoadablePage extends StatelessWidget {
  final List<Widget> children;
  final bool isLoading;

  const LoadablePage({Key key, this.isLoading, this.children})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: children
        ..add(Align(
          child: Visibility(
            visible: isLoading,
            child: Loading(
              indicator: BallPulseIndicator(),
              color: ColorsD.redDefault,
            ),
          ),
        )),
    );
  }
}

class AlertDialogs {

  static Future failed(BuildContext context,  {String content})async{
    await defaultDialog(context,'فشلت العملية',Icons.warning, content: content);
  }
  static Future success(BuildContext context,  {String content})async{
    await defaultDialog(context,'تمت العملية',Icons.check, content: content);
  }

   static Future defaultDialog(BuildContext context, String title, IconData icon, {String content}){
    return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: ColorsD.redDefault
                )
              ),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        icon,
                        color: ColorsD.redDefault,
                        size: 30,
                      ),
                      TextD(
                        title: title,
                        textColor: ColorsD.redDefault,
                        fontSize: 24,
                      ),
                    ],
                  ),
                  Divider(
                    color: ColorsD.redDefault,
                    height: 10,
                  )
                ],
              ),
              content: Container(
                // color: Colors.black,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 8,
                child: Align(
                  child: TextD(
                    title: content,
                    fontSize: 22,
                  ),
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    // ClippedButton(
                    //   width: MediaQuery.of(context).size.width / 4,
                    //   child: TextD(title: 'لا',textColor: ColorsD.redDefault, fontSize: 18,),
                    //   color: Colors.grey[100],
                    //   onTapCallback: (){},
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(right: 37.0),
                      child: ClippedButton(
                        width: MediaQuery.of(context).size.width / 2,
                        child: TextD(
                          title: 'موافق',
                          textColor: Colors.white,
                          fontSize: 18,
                        ),
                        color: ColorsD.redDefault,
                        onTapCallback: () => Navigator.of(context).pop(),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
  }
}

class ClippedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double width;
  final Function onTapCallback;

  ClippedButton({
    this.child,
    this.color = Colors.grey,
    this.onTapCallback,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallback,
      child: Container(
        margin: EdgeInsets.only(right: 16, left: 16, top: 6, bottom: 6),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: width ?? MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 18, left: 18),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
