import 'package:flutter/material.dart';
import 'package:mubrm_tag/confing/general.dart';

class StaggerAnimation extends StatelessWidget {
  final VoidCallback onTap;
  final String titleButton;
  final String buttonType;
  final double begin;
  final double height;

  StaggerAnimation({
    Key key,
    this.buttonController,
    this.onTap,
    this.titleButton = "Sign In",
    this.buttonType = "sing_up",
    this.begin = 150,
    this.height = 50,
  })  : buttonSqueezeanimation = Tween(
          begin: begin,
          end: buttonType == 'accept' ? 48.0 : 48.0,
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              0.0,
              0.150,
            ),
          ),
        ),
        containerCircleAnimation = EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 30.0),
          end: const EdgeInsets.only(bottom: 0.0),
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              0.500,
              0.800,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final AnimationController buttonController;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation buttonSqueezeanimation;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSqueezeanimation.value,
        height: height,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(const Radius.circular(40.0)),
          gradient: LinearGradient(colors: <Color>[color1, color1]),
        ),
        child: buttonSqueezeanimation.value > 75.0
            ? singUpButton(context)
            : Container(
                padding: EdgeInsets.all(6.0),
                child: CircularProgressIndicator(
                  value: null,
                  strokeWidth: 1.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }

  Widget singUpButton(context) {
    return Container(
        width: 300,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(colors: [color1, color2]),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Text(
          titleButton,
          style: kTextStyle,
          textAlign: TextAlign.center,
        ));
  }

  Widget loginButton(context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: Offset(1, 3),
              spreadRadius: 2,
              blurRadius: 2,
            )
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18))),
      child: Text(
        titleButton ?? 'Log in',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
