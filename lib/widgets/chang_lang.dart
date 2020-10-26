



import 'package:flutter/material.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/models/app_model.dart';
import 'package:provider/provider.dart';

class ChangeLang extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ChangeLang();
  }

}
class _ChangeLang extends State<ChangeLang>{
  @override
  Widget build(BuildContext context) {
    String lang = Provider.of<ModelApp>(context,listen: false).locale;
    return Container(
      padding: EdgeInsets.all(6.0),
      width: 200,
      decoration: kBoxDecorationEditText,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async{
               bool ok = await Provider.of<ModelApp>(context,listen: false).changeLanguage('ar', context);
              },
              child: Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                    color: lang == 'ar' ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                alignment: Alignment.center,
                child: Text('عربي'),),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: ()async{
                bool ok = await Provider.of<ModelApp>(context,listen: false).changeLanguage('en', context);
              },

              child: Container(
                padding: EdgeInsets.all(6.0),

                decoration: BoxDecoration(
                    color: lang == 'en' ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                alignment: Alignment.center,

                child: Text('English'),),
            ),
          )
        ],
      ),
    );
  }

}