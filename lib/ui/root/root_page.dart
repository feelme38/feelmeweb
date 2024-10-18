import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../presentation/theme/drawables.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Center(child: SvgPicture.asset(Drawables.logo));
      }
    );
  }
}