import 'package:flutter/material.dart';

enum Buttons 
  {
    Google,
    Facebook,
  }
  class ButtonBuilder extends StatelessWidget {
    final IconData icon;
    final bool mini;
    final String title;
    final String signInText;
    final Color textColor,backgroundColor,splashColor;
    final Function onPressed;
    final EdgeInsets padding;
    final double elevation;
    final double width;
    ButtonBuilder({
        Key key,
      @required this.backgroundColor, 
      @required this.icon, 
      @required this.onPressed,
      this.mini = false,
      this.title = '', 
      this.signInText = 'Sign in with',
      this.textColor = Colors.white,
      
      this.splashColor = Colors.white30,
      this.padding = const EdgeInsets.all(10.0),
      this.elevation = 2.0,
      this.width,

    }): assert(title != null),
        assert(icon != null),
        assert(textColor != null),
        assert(backgroundColor != null),
        assert(onPressed != null),
        assert(mini != null),
        assert(elevation != null);
    
    @override
    Widget build(BuildContext context) {
      return MaterialButton(
        key: key,
      minWidth: mini ? 35.0 : null,
      elevation: elevation,
      padding: padding,
      color: backgroundColor,
      onPressed: onPressed,
      splashColor: splashColor,
      child: mini
       ? Container(
              width: 35.0,
              height: 35.0,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ):
            Container(
              constraints: BoxConstraints(
                maxWidth: width ?? MediaQuery.of(context).size.width / 1.5,
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 20),
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "$signInText $title",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      );
    }
  }
  