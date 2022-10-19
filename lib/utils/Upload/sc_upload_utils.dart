/// 上传图片
import 'package:dio/dio.dart' as DIO;
import 'package:http_parser/http_parser.dart';
import 'package:smartcommunity/network/sc_http_manager.dart';
import 'package:smartcommunity/network/sc_url.dart';

class SCUploadUtils {
  static uploadHeadPic({required String imagePath}) async {
    List fileList = [];
    String imageName = imagePath.substring(imagePath.lastIndexOf("/") + 1, imagePath.length);
    var file = await DIO.MultipartFile.fromFile(imagePath,
        filename: imageName, contentType: MediaType('image', 'jpeg'));
    fileList.add(file);
    DIO.FormData formData = DIO.FormData.fromMap({'file': fileList});
    print("参数:${formData}");
    SCHttpManager.instance.post(
        url: SCUrl.kUploadHeadPicUrl,
        params: formData,
        success: (value) {
          print('成功:$value');
        },
        failure: (value) {
          print('失败:$value');
        });
  }
}
