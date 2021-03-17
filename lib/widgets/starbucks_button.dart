import 'package:flutter/material.dart';


class StarbucksButton extends StatelessWidget {

  final String title;
  final Function onTap;
  final TextStyle textStyle;
  final List<BoxShadow> boxShadow;
  final Border border;
  final double width;
  final Widget icon;

  List<Color> colors;

  StarbucksButton(this.title, {this.onTap, this.colors,this.textStyle, this.boxShadow, this.border, this.width, this.icon}) {
    if (colors == null) {
      colors = [
        Color(0xff2B6D4E),
        Color(0xff2B6D4E),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == null ? double.infinity : this.width,
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Container(

            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors),
                borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: boxShadow,
            border: border
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) icon,
                Text(
                  title,
                  style:textStyle
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
