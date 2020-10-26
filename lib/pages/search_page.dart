


import 'package:flutter/material.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/widgets/drawer_widget.dart';
import 'package:mubrm_tag/widgets/list_item_icons.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> with TickerProviderStateMixin{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Animation<double> menuAnimation;
  AnimationController menuController;


  @override
  void initState() {
    menuController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));

    menuAnimation = Tween<double>(begin:0.0, end: 0.25)
        .animate(menuController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: DrawerWidget(pageName: 'search_page',changed: (isOpen){
        !isOpen ? menuController.reverse() : menuController.forward();

      },),
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 70),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24.0),
                    bottomRight: Radius.circular(24.0))),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: 70,top: 110),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'البحث بالاسم',
                        border: InputBorder.none,
                        icon: Icon(Icons.search_sharp,color: Colors.grey,),
                      ),
                      cursorColor: Colors.black,

                      style: kTextStyleEditText.copyWith(fontSize: 20),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: Color(0xFFEFEFEF),

                    ),
                    margin: EdgeInsets.only(left: 36.0,right: 36.0),
                    padding: EdgeInsets.only(right: 12,left: 12),
                  ),
                  SizedBox(
                    height: 48,
                  )

                ],
              ),
            ),
          ),
          Positioned(
              top: 48,
              left: 0,
              right: 0,
              child: Container(
                child: Row(
                  children: [
                    GestureDetector(

                      child: Container(
                        margin: EdgeInsets.only(right: 24),
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'images/PNG/srq.png',
                          width: 48,
                          height: 48,
                        ),
                      ),
                      onTap: (){
                      },
                    ),
                    Expanded(child: Container(
                      child: Text('بيانات الأسماء',style: TextStyle(fontSize: 28),),
                      alignment: Alignment.center,
                    )),
                    RotationTransition(turns: menuAnimation,child: GestureDetector(
                      onTap: (){
                        _scaffoldKey.currentState.openEndDrawer();

                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 24),
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'images/PNG/menu.png',
                          width: 48,
                          height: 48,
                        ),
                      ),
                    ),alignment: Alignment.center,),
                  ],
                ),
              )),

        ],
      ),
    );
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }
}
