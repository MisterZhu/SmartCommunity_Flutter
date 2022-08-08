import 'package:get/get.dart';

/// 用户协议和隐私政策的GetXController

class SCBasePrivacyController extends GetxController {
  /// 标题
  String title = '';

  /// 正文
  String content = '';

  /// 描述
  String description = '';

  /// 同意
  String agreeString = '同意';

  /// 用户协议
  String userAgreement = '';

  /// 用户协议url
  String userAgreementUrl = '';

  /// 和
  String andString = '和';

  /// 隐私政策
  String privacyPolicy = '隐私政策';

  /// 隐私政策url
  String privacyPolicyUrl = '';

  /// 是否同意相关协议，默认不同意
  bool isAgree = false;

  @override
  onInit() {
    super.onInit();
    title = '邑生活用户协议和隐私政策更新';
    content = '为了提供更好的服务功能,我们会根据您的授为了提供更好的服务功能,我们会根据您的授为了提供更好的服务功能,我们会根据您的授为了提供更好的服务功能,我们会根据您的授为了提供更好的服务功能,我们会根据您的授为了提供更好的服务功能,我们会根据您的授为了提供更好的服务功能,我们会根据您的授为了提供更好的服务功能,我们会根据您的授为了提供更好的服务功能,我们会根据您的授为了提供更好的服务功能,我们会根据您的授为了提供更好的服务功能,我们会根据您的授为了提供更好的服务功能,我们会根据您的授为了提供更好的服务功能,我们会根据您的授为了提供更好的服务功能,我们会根据您的授';
  }

  /// 更新勾选协议状态
  updateAgreementState() {
    isAgree = !isAgree;
    update();
  }
}