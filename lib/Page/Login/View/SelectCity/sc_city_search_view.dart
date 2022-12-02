import 'package:flutter/cupertino.dart';
import '../../../../Constants/sc_asset.dart';
import '../../../../Constants/sc_colors.dart';
import '../../../../Constants/sc_fonts.dart';


/// 静态搜索框

class SCCitySearchView extends StatelessWidget {

  final Function? textViewTapAction;
  final String? placeHolder;
  const SCCitySearchView({Key? key, this.placeHolder, this.textViewTapAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  /// body
  Widget body() {
    return GestureDetector(
      child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            height: 30.0,
            decoration: BoxDecoration(
                color: SCColors.color_F2F3F5,
                borderRadius: BorderRadius.circular(15.0)
            ),
            child: Row(
              children: [
                searchIcon(),
                const SizedBox(width: 10.0,),
                searchView()
              ],
            )
        ),
      onTap: () {
        if (textViewTapAction != null) {
            textViewTapAction?.call();
        }
      },
    );

  }

  /// 搜索icon
  Widget searchIcon() {
    return Image.asset(SCAsset.iconLocationSearchCity, width: 16.0, height: 16.0,);
  }

  Widget searchView() {
    return Expanded(child: Text(
      placeHolder!,
      textAlign: TextAlign.left,
      style: const TextStyle(
          fontSize: SCFonts.f14,
          fontWeight: FontWeight.normal,
          color: SCColors.color_B0B1B8),
      )
    );
  }

}

