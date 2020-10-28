import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/model/social_media.dart';
import 'package:mubrm_tag/models/app_model.dart';
import 'package:provider/provider.dart';

class RowItem extends StatefulWidget {
  final SocialMedia media;
  final Function onChanged;

  const RowItem({Key key, this.media, this.onChanged}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RowItem();
  }
}


class _RowItem extends State<RowItem> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final TextEditingController controller = TextEditingController();
  bool showMessage = false;


  @override
  void initState() {
    setState(() {
      controller.text = widget.media.value;
    });
    super.initState();

  }
  @override
  void dispose() {
    printLog('dispose', widget.media.id);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String lang = Provider.of<ModelApp>(context,listen: false).locale;
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, top: 24),
      decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 12,
              ),

              Image.asset(
                'images/PNG/${widget.media.socialIcon}.png',
                width: 36,
                height: 36,
              ),
              Expanded(
                child: FormBuilder(
                  key: _fbKey,
                  child: Container(
                    child: FormBuilderTextField(
                      validators: [
                        FormBuilderValidators.required(
                            errorText: 'هذا الحقل فارغ يرجى ملئ الحقل'),
                      ],
                      style: kTextStyleEditText,
                      decoration: InputDecoration(border: InputBorder.none),
                      attribute: 'value',
                      controller: controller,
                      // initialValue: widget.media.value,
                    ),
                    margin: EdgeInsets.only(left: 3,right: 3),
                  ),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              InkWell(
                child: Icon(Icons.clear_rounded),
                onTap: (){
                  SocialMedia media = SocialMedia(
                    socialName: widget.media.socialName,
                    id: widget.media.id,
                    socialIcon: widget.media.socialIcon,
                    socialIsSelect: false,
                    socialAddedTo: false,
                    socialLinkAndroid: widget.media.socialLinkAndroid,
                    socialLinkWeb: widget.media.socialLinkWeb,
                    socialLinkIos: widget.media.socialLinkIos,
                    messageAR: widget.media.messageAR,
                    messageEN: widget.media.messageEN,

                    value: null,
                  );
                  // FirebaseFirestore.instance
                  //     .collection('users')
                  //     .doc(user.id)
                  //     .collection('socialMediaSelectedList')
                  //     .doc(widget.media.firebaseId)
                  //     .update(media.toJson())
                  //     .then((value) {
                  // });
                  setState(() {
                    controller.text = '';
                  });

                },
              ),
              SizedBox(
                width: 6,
              ),

              InkWell(
                onTap: (){
                  setState(() {
                    showMessage = !showMessage;
                  });
                },
                child: Icon(Icons.error_rounded),
              ),
              SizedBox(
                width: 12,
              ),
            ],
          ),
         AnimatedContainer(
           height: showMessage ? 70 : 0,
           curve: Curves.bounceInOut,
           duration: Duration(milliseconds: 300),

         alignment: Alignment.center,
         padding: EdgeInsets.only(left: 12,right: 12),
         child: Column(
           children: [
             Container(
               margin: EdgeInsets.only(bottom: 6),
               height: showMessage ? 1: 0,
               color: Theme.of(context).primaryColor,
             ),
             Text(showMessage?lang == 'ar' ? widget.media.messageAR : widget.media.messageEN:'',textAlign: TextAlign.center,)
           ],
         ),),

        ],
      ),
    );
  }
}
