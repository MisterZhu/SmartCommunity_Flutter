
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smartcommunity/Constants/sc_agreement.dart';
import 'package:smartcommunity/Utils/Router/sc_router_path.dart';
import '../../../Constants/sc_asset.dart';
import 'package:sc_uikit/sc_uikit.dart';
import '../../../Constants/sc_type_define.dart';
import '../../../Skin/View/sc_custom_scaffold.dart';
import '../../../Utils/Colors/sc_color_hex.dart';
import '../../../Utils/Router/sc_router_helper.dart';
import '../../../Utils/sc_utils.dart';
import '../../Login/View/Login/sc_agreement_item.dart';
import '../GetXController/sc_logoff_controller.dart';

/// 注销账户page
class SCLogoffPage extends StatefulWidget {

  const SCLogoffPage({Key? key}) : super(key: key);

  @override
  SCLogoffState createState() => SCLogoffState();
}

class SCLogoffState extends State<SCLogoffPage> {

  SCLogoffController state = Get.put(SCLogoffController());

  /// 验证码controller
  TextEditingController codeController = TextEditingController();
  /// 验证码focusNode
  FocusNode codeNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SCCustomScaffold(title: "注销账户", centerTitle: true, elevation: 0, body: body());
  }

  /// body
  Widget body() {
    return GestureDetector(
      onTap: (){
        SCUtils().hideKeyboard(context: context);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: SCColors.color_FFFFFF,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: listView())
      ),
    );
  }

  Widget listView() {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return getCell(index: index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return getSeparateItem(index: index);
        },
        itemCount: 6);
  }

  /// cell
  Widget getCell({required int index}) {
    if (index == 0) {
      return titleItem();
    } else if (index == 1) {
      return contentItem();
    }  else if (index == 2) {
      return phoneItem();
    } else if (index == 3) {
      return codeItem();
    } else if (index == 4) {
      return agreementItem();
    } else if (index == 5) {
      return btnItem();
    } else {
      return const SizedBox();
    }
  }

  /// 标题内容
  Widget titleItem() {
    return const Padding(
      padding: EdgeInsets.only(top: 52.0,),
      child: Text(
      '请验证手机号',
      textAlign: TextAlign.left,
      maxLines: 1,
      style: TextStyle(
          fontSize: SCFonts.f20,
          fontWeight: FontWeight.w500,
          color: SCColors.color_1B1C33),
    ),);
  }

  /// 说明内容
  Widget contentItem() {
    return const Text(
      '此手机号为您开通电子钱包所使用的手机号',
      textAlign: TextAlign.left,
      maxLines: 1,
      style: TextStyle(
          fontSize: SCFonts.f13,
          fontWeight: FontWeight.w400,
          color: SCColors.color_5E5E66),
    );
  }

  /// 手机号item
  Widget phoneItem() {
    String phoneText = state.phone?.replaceRange(3, 7, '****') ?? '';
    return Container(
      width: double.infinity,
      height: 48.0,
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: SCColors.color_999999, width: 0.5)
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 17.0),
      child: Text(
        phoneText,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: SCFonts.f16,
          fontWeight: FontWeight.w400,
          color: SCColors.color_1B1C33,
        ),
      )
    );
  }

  /// 验证码模块
  Widget codeItem() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: textFieldItem()),
        const SizedBox(width: 10,),
        codeBtnItem(),
      ],
    );
  }

  /// 验证码输入框
  Widget textFieldItem() {
    return Container(
      height: 48.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: SCColors.color_FFFFFF,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: SCColors.color_999999, width: 0.5)
      ),
      padding: const EdgeInsets.only(left: 17.0, top: 0.0, bottom: 0.0, right: 0.0),
      child: codeTextField(),
    );
  }

  /// 验证码输入框
  codeTextField() {
    return TextField(
      controller: codeController,
      maxLines: 1,
      cursorColor: SCColors.color_1B1C33,
      cursorWidth: 2,
      focusNode: codeNode,
      inputFormatters: [
        LengthLimitingTextInputFormatter(6),
      ],
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        hintText: "请输入短信验证码",
        hintStyle: TextStyle(fontSize: SCFonts.f16, color: SCColors.color_B0B1B8),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        isCollapsed: true,
      ),
      onChanged: (value) {
        updateBtnStatus(value);
      },
      keyboardType: TextInputType.number,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.next,
    );
  }

  /// 更新确认按钮的状态
  updateBtnStatus(String text) {
    state.code = text;
    /// 手机号格式化
    if (text.length == 6) {
        if (mounted) {
          setState(() {
            state.updateSureButtonState(enable: true);
          });
        }
    } else {
        if (mounted) {
          setState(() {
            state.updateSureButtonState(enable: false);
          });
        }
    }
  }

  /// 获取验证码按钮
  Widget codeBtnItem() {
    return GetBuilder<SCLogoffController>(builder: (state) {
      Color codeColor = state.isCodeBtnEnable ? SCColors.color_FF6C00 : SCColors.color_8D8E99;
      return Container(
        width: 133.0,
        height: 48.0,
        decoration: BoxDecoration(
            color: SCColors.color_FFFFFF,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: codeColor, width: 0.5)
        ),
        child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text(
              state.codeBtnText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SCFonts.f16,
                fontWeight: FontWeight.w500,
                color: codeColor,
              ),
            ),
            onPressed: () {
                if (state.isCodeBtnEnable) {
                  print('发送验证码');
                  // state.sendCode();
                  /// 测试
                  state.initTimer();

                }
            }),
      );

    });
  }

  /// 用户协议
  Widget agreementItem() {
    List<dynamic> list = [
      {
        'type': SCTypeDefine.richTextTypeImage,
        'title': '',
        'imageUrl': SCAsset.iconNotAgree,
        'url': '',
        'color': SCHexColor.colorToString(SCColors.color_FFFFFF)
      },
      {
        'type': SCTypeDefine.richTextTypeText,
        'title': '我已阅读并同意',
        'imageUrl': '',
        'url': '',
        'color': SCHexColor.colorToString(SCColors.color_1B1C33)
      },
      {
        'type': SCTypeDefine.richTextTypeText,
        'title': '《用户服务协议》',
        'imageUrl': '',
        'url': SCAgreement.userAgreementUrl,
        'color': SCHexColor.colorToString(SCColors.color_FF6C00)
      },
      {
        'type': SCTypeDefine.richTextTypeSpace,
        'title': '',
        'imageUrl': '',
        'url': '',
        'color': SCHexColor.colorToString(SCColors.color_FFFFFF)
      }
    ];
    return GetBuilder<SCLogoffController>(builder: (state) {
      return SCAgreementItem(
        list: list,
        isAgree: state.isAgree,
        agreeAction: () {
          state.updateAgreementState();
        },
        agreementDetailAction: (String title, String url) {
          var params = {'title' : title, 'url' : url};
          SCRouterHelper.pathPage(SCRouterPath.webViewPath, params);
        },
      );
    });
  }

  /// 确定按钮
  Widget btnItem() {
    return SizedBox(
      width: double.infinity,
      height: 40.0,
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          color: SCColors.color_FF6C00,
          borderRadius: BorderRadius.circular(4.0),
          child: const Text(
            '确定',
            style: TextStyle(
              fontSize: SCFonts.f16,
              fontWeight: FontWeight.w500,
              color: SCColors.color_FFFFFF,
            ),
          ),
          onPressed: () {
            if (state.isSureBtnEnable == false) {
              return;
            }
            if (state.isAgree == false) {
              SCToast.showTipWithGravity(msg: '请同意用户服务协议', gravity: ToastGravity.CENTER);
              return;
            }
            /// 去请求注销接口
            ///
            print('code======${state.code}=====${state.phone}');
          }),
    );
  }

  /// 分割线
  Widget getSeparateItem({required int index}) {
    if (index == 0) {
      return const SizedBox(height: 12.0,);
    } else if (index == 1) {
      return const SizedBox(height: 35.0,);
    } else if (index == 2) {
      return const SizedBox(height: 12.0,);
    } else if (index == 3) {
      return const SizedBox(height: 18.0,);
    } else if (index == 4) {
      return const SizedBox(height: 43.0,);
    } else {
      return const SizedBox();
    }
  }

  @override
  dispose() {
    super.dispose();
    codeNode.dispose();
    codeController.dispose();
  }

}