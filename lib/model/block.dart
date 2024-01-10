import 'package:wowowwish/model/them.dart';

class Block{//
  int blockId;
  int userUid;
  DateTime dateTime;
  MyThem? myThem;
  setMyThem(MyThem myThemPara){
    myThem=myThemPara;
  }
  Block(this.blockId,this.userUid,this.dateTime);
}