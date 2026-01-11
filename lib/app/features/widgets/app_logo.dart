import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../assets_paths.dart';

class Applogo extends StatelessWidget {
  const Applogo({
    super.key, this.width, this.height
  });
 final double? width;
 final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetPaths.logoSvg,
    width: width ?? 100, //dile thik ase na dile 100 ni nibe auto
    height:  height,);
  }
}
