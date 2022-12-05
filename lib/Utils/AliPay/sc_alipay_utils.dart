
import 'package:sc_uikit/sc_uikit.dart';
import 'package:tobias/tobias.dart' as tobias;
import '../../Constants/sc_default_value.dart';

class SCAliPayUtils {

  /// 支付宝支付
  static void aliPay() async {
    String test = '2PG+eLf85AVnFaBXY2JC7jsVjPsy1xnn/0lpSMCiT8fdfQSr6a0jRHxdbjEwf6oreC2L4MKYLbMi/Gr1d8Gg3EqY75A0zos8bEFqzEBMFLCD6wiV1CohfN9mirNG/Jiyzgfd0WSzIwiEO/CCMusXwYTRLcaEeMlIAROAssZ358ihcAlaJKLtCoa2Qg98IBW5rVp7IlFTjrjmAe7HpF7/GKEhA0ZoQgj1DYQDEafaRp26goxCLa1DpeBMlUT+QM+oj/XjY5E3RDy6b97nkAGYPWKvQw9DyWmkIFWP0UCWu/uevdaVoOD4HjZMLijfkOBnaoPl879m++QS7wDrohJ+mTUXxid15bO2OBSQ9EfCJY15dJYDSCJgl1FkbRGT6HPVHYsL5yYRyA23K57hF9dB4zkz6uhGrp0A1yv7xSo9/rtc23/mnBvzELJB4FDlMKWtz8dOxmKyZoqL/HN7RcdAtaKtd1Sh/SXtMZmre7LneP+47guGFWr3FuMhdsVQgJCg/4knOrwNP97j8wd1eGB1J+rcCg8ttbT1eR0owPyeSijJ5LIeRe/3TTp7llwNXQoNonbyJKgI1CoOUi2Sr0pUN7L13A0p7MiX6+WGYP9wJZyBQr1xXy0tReHSVXdx2IYk5UkhBuFXoVKaByWsJGYJMfCZw49Vru79Y9njeW8vhzfCmrMdkMHNpyEVUR9e2HzSgLe5AXrYqF8eQb65VA7O0cgjohUE79W838j7XYyp8JES83VGSYYynSZ//KaXcLHJSAOCZE9KuJBqN9iflhuJJfg8Zc4eKkiXFasIRARwFaf1BxGkeBXzoLqWkaIY9vgzEtXiX/xcaJ9B2uNrbxHO+pKTiLDZFQZKHMDvIwGSS0IrP0dGalyMaGTyTQBKKsGRvFcCxyANGcTc3pHjJQuGavh9Hcy0X04QjcDV7xNfLzRrIk/1imxo/VAwFvbdCH0zJn2vGSak2XZdGKT1ZTDSH33E3x/ISugqm982R+5/BvV6bwuAEsBgZV8NId7jijWmvmCS0wfFtsuzO4VZvpuUlZByuBIAcu41XKlKT8NjBE5yxH7WOY2GtdxzNb7/9T4HXV6amcX3riPA5jO+uQefny2bL6vJwbekviDs0FXW1FGnFJi+Q2vO5CHC+Jay+tKTuDb8goEqEbW1dMgZkx8LWcRiabp24WoTpe+ccJqXMj5dDGgZX8MLgnsN+zD1V3B799yz3K363lIHNYwbuhKx+Ijo8t74mk+H50rGFeyFFKEjbr6w4EPh9K8AcHycxpFcd6J/X0iz/DspYcNssrS8XLi46+pErA0K5/9HNbBBp/f49tX41ZHZ+fEmu1Vp6I6wTlcA4EPEGMcsdo6mogJ3F7jbme8iz59TUZVLE/zns4HEtmV0Wuth0GUpPgWYmHLv';
    /// 判断是否安装支付宝
    var isInstalled = await tobias.isAliPayInstalled();
    if (isInstalled) {
      tobias.aliPay(test).then((payResult) {
        if (payResult['resultStatus'] == '9000' || payResult['resultStatus'] == 9000) {
          SCToast.showTip(SCDefaultValue.paySuccessTip);
        } else {
          SCToast.showTip(payResult['memo']);
        }
      });
    } else {
      SCToast.showTip(SCDefaultValue.unInstallAliPayTip);
    }
  }
}