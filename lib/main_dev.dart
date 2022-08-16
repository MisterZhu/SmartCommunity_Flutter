/// 研发环境
import 'package:smartcommunity/constants/sc_enum.dart';
import 'package:smartcommunity/network/sc_config.dart';
import 'package:smartcommunity/sc_app.dart';

void main() async{
  SCConfig.env = SCEnvironment.develop;
  startApp();
}