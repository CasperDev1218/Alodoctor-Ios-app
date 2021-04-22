import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient/component/Bottombar.dart';
import 'package:flutter_patient/component/Chatcomponent.dart';
import 'package:flutter_patient/component/CurrentConsultant.dart';
import 'package:flutter_patient/component/MainHeader.dart';
import 'package:flutter_patient/component/NavDrawer.dart';
import 'package:flutter_patient/component/OldConsultant.dart';
import 'package:flutter_patient/component/menulistpage.dart';
import 'package:flutter_patient/controllers/consultantcontroller.dart';
import 'package:flutter_patient/screen/VideoPage.dart';
import 'package:flutter_patient/utils/Configs.dart';
import 'package:flutter_patient/utils/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:permission_handler/permission_handler.dart';

import 'VoicePage.dart';

class ChatPage extends StatefulWidget {
  ChatPage();

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends StateMVC<ChatPage> with SingleTickerProviderStateMixin{

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TabController _controller;
  int _currentIndex = 0;

  consultantcontroller _con;

  ChatPageState() : super(consultantcontroller()){
    _con = controller;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(vsync: this, length: 4);
    _controller.addListener(_handleTabSelection);
    Configs.menu_flag = false;
    _controller.animateTo(3);
    Configs.tabController = _controller;
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  _handleTabSelection() {
    setState(() {
      _currentIndex = _controller.index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: NavDrawer(scaffoldKey),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child:Column(
            children: [
              MainHeader('ﺍﺧﺘﺮ ﻃﺒﻴﺒﻚ ﻭﺍﺳﺘﺸﺮ', scaffoldKey),
              Expanded(child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                                width: Configs.calcheight(7), color: bottomcolor),
                          ),
                        ),
                        child:  TabBar(
                            isScrollable: true,
                            controller: _controller,
                            unselectedLabelColor:
                            Colors.black.withOpacity(0.3),
                            indicatorColor: Colors.white,
                            labelPadding: EdgeInsets.only(left: 4, right: 4),
                            tabs: [
                              Tab(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(Configs.calcheight(36))),
                                    color: _currentIndex == 0 ? Color(0xff159E4C): Color(0xffF9FAFC),
                                    border: Border.all(
                                        color: Color(0xffD3D3D3)
                                    ),
                                  ),
                                  width: Configs.calcwidth(265),
                                  height: Configs.calcheight(72),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'ﺍﺳﺘﺸﺎﺭﺍﺗﻲ ﺍﻟﺴﺎﺑﻘﺔ',
                                    style: TextStyle(
                                        fontSize: Configs.calcheight(25),
                                        color: _currentIndex == 0 ? Colors.white: Color(0xff6a6a6a)
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(Configs.calcheight(36))),
                                    color:  _currentIndex == 1 ? Color(0xff159E4C): Color(0xffF9FAFC),
                                    border: Border.all(
                                        color: Color(0xffD3D3D3)
                                    ),
                                  ),
                                  width: Configs.calcwidth(180),
                                  height: Configs.calcheight(72),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'ﺍﻻﻗﺴﺎﻡ',
                                    style: TextStyle(
                                        fontSize: Configs.calcheight(25),
                                        color: _currentIndex == 1 ? Colors.white: Color(0xff6a6a6a)
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(Configs.calcheight(36))),
                                      color: _currentIndex == 2 ? Color(0xff159E4C): Color(0xffF9FAFC),
                                      border: Border.all(
                                          color: Color(0xffD3D3D3)
                                      ),
                                    ),
                                    width: Configs.calcwidth(250),
                                    height: Configs.calcheight(72),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'استشاراتي الحالية',
                                          style: TextStyle(
                                              fontSize: Configs.calcheight(25),
                                              color: _currentIndex == 2 ? Colors.white: Color(0xff6a6a6a)
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Image.asset( _currentIndex == 2 ? 'assets/images/ic_chatting_2.png' :  'assets/images/ic_chatting_1.png',
                                          width: Configs.calcheight(35),
                                          height: Configs.calcheight(35),)
                                      ],
                                    )
                                ),
                              ),
                              Tab(
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(Configs.calcheight(36))),
                                      color:  _currentIndex == 3 ? Color(0xff159E4C): Color(0xffF9FAFC),
                                      border: Border.all(
                                          color: Color(0xffD3D3D3)
                                      ),
                                    ),
                                    width: Configs.calcwidth(200),
                                    height: Configs.calcheight(72),
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'ﺍﺧﺘﺮ ﺍﻟﻄﺒﻴﺐ',
                                            style: TextStyle(
                                                fontSize: Configs.calcheight(25),
                                                color:  _currentIndex == 3 ? Colors.white: Color(0xff6a6a6a)
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset( _currentIndex == 3 ? 'assets/images/ic_consult_2.png' : 'assets/images/ic_consult_1.png',
                                            width: Configs.calcheight(35),
                                            height: Configs.calcheight(35),)
                                        ],
                                      ),
                                      onTap: (){
                                        Configs.menu_flag = false;
                                        _controller.animateTo(3);
                                        setState(() { });
                                      },
                                    )
                                ),
                              ),
                            ]),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: _controller,
                            children: <Widget>[
                              OldConsultant(_con),
                              Menulistpage(),
                              CurrentConsultant(_con),
                              Chatcomponent()
                            ],
                          ),
                        ),
                      )
                    ],
                  )),)
            ],
          )
        ),
        bottomNavigationBar: Bottombar(1),
      ),
    );
  }
  void getcalling() {
    if (Configs.conmodel.type == 'video' ||
        Configs.conmodel.type == 'voice') {
      CollectionReference callRef = Firestore.instance.collection("calls");
      callRef.where("channel_id", isEqualTo: "${Configs.conmodel.id.toString()}").getDocuments().then((value) async {
        if(value.documents.length > 1){
          if(value.documents[0]['response'] == 'Awaiting'){
            Configs.callmodel = Configs.conmodel;
            await PermissionHandler().requestPermissions(Configs.callmodel.type == "video"
                ? [PermissionGroup.camera, PermissionGroup.microphone]
                : [PermissionGroup.microphone]);
            showDialog(
                barrierDismissible: true,
                context: Configs.con_context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(Configs.calcheight(38)))),
                    child: Container(
                        width: Configs.calcwidth(460),
                        height: Configs.calcheight(330),
                        padding: EdgeInsets.all(Configs.calcheight(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Configs.calcheight(37),
                            ),
                            Text('ﻣﻜﺎﻟﻤﺔ ﻭﺍﺭﺩﺓ ﻣﻦ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Configs.calcheight(34),
                              ),),
                            SizedBox(
                              height: Configs.calcheight(37),
                            ),
                            Text(Configs.callmodel.fname + ' ' + Configs.callmodel.lname,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Configs.calcheight(34),
                              ),),
                            Container(
                              width: Configs.calcwidth(398),
                              margin: EdgeInsets.only(top: Configs.calcheight(20)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: Configs.calcwidth(187),
                                    height: Configs.calcheight(65),

                                    child: FlatButton(
                                      color: Color(0xffff005c),
                                      textColor: Colors.white,
                                      padding: EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(Configs.calcheight(50)),
                                      ),
                                      onPressed: () async {
                                        await Firestore.instance.collection("calls").document(Configs.callmodel.id.toString())
                                            .updateData(
                                            {'response': 'Decline'});
                                        await Firestore.instance.collection("calls").document(Configs.callmodel.id.toString())
                                            .updateData({'calling': false});
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'ﺭﻓﺾ',
                                        style: TextStyle(
                                          fontSize: Configs.calcheight(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: Configs.calcwidth(187),
                                    height: Configs.calcheight(65),

                                    child: FlatButton(
                                      color: Color(0xff30BB68),
                                      textColor: Colors.white,
                                      padding: EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(Configs.calcheight(50)),
                                      ),
                                      onPressed: () async {
                                        await Firestore.instance.collection("calls").document(Configs.callmodel.id.toString())
                                            .updateData(
                                            {'response': "Pickup"});
                                        Navigator.pop(context);
                                        if(Configs.callmodel.type == 'video'){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>VideoPage(
                                                  channelName: Configs.callmodel.id.toString(),
                                                  role: ClientRole.Broadcaster,
                                                  callType: 'VideoCall')
                                          ));
                                        } else {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>VoicePage(
                                                  channelName: Configs.callmodel.id.toString(),
                                                  role: ClientRole.Broadcaster,
                                                  callType: 'VoiceCall')
                                          ));
                                        }
                                      },
                                      child: Text(
                                        'ﻗﺒﻮﻝ',
                                        style: TextStyle(
                                          fontSize: Configs.calcheight(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                  );
                });
          }
        }
      });
    }
  }
}
