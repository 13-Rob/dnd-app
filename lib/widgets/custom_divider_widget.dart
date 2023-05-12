import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Divider(
      thickness: 2,
      color: Theme.of(context).dividerColor,
      indent: size.width * 0.05,
      endIndent: size.width * 0.05,
    );
  }
}
