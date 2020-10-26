


import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mubrm_tag/model/social_media.dart';

class ItemIconAddLink extends StatelessWidget {
 final SocialMedia media;
 final SocialMedia lastMediaSelected;
  const ItemIconAddLink({Key key, this.media, this.lastMediaSelected,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(left: 6,right: 6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child:  Stack(
              children: [
                Image.asset('images/PNG/${media.socialIcon}.png',width: 50,height: 50,),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: !media.socialAddedTo ? Colors.transparent :Colors.white.withOpacity(0.9),
                  ),
                )
              ],
            )
          ),

          Container(
            child: Text(media.socialName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: !media.socialAddedTo ? Colors.black :Colors.grey.withOpacity(0.5)),),
          )
        ],
      ),
    );
  }

}