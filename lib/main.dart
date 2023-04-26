import 'package:smartcommunity/Constants/sc_enum.dart';
import 'package:smartcommunity/Network/sc_config.dart';
import 'package:smartcommunity/sc_app.dart';

void main() async{
  SCConfig.env = SCEnvironment.develop;
  startApp();
}
