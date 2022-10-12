
import 'package:flutter/cupertino.dart';

class SCRealNameVerifyTextField extends StatefulWidget {

  @override
  SCRealNameVerifyTextFieldState createState() => SCRealNameVerifyTextFieldState();
}

class SCRealNameVerifyTextFieldState extends State<SCRealNameVerifyTextField> {
  /// 姓名controller
  TextEditingController nameController = TextEditingController();
  /// 身份证号controller
  TextEditingController numberController = TextEditingController();

  /// 姓名focusNode
  FocusNode nameNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return body();
  }

  @override
  initState() {
    super.initState();
    
  }

  Widget body() {
    return Container();
  }

}