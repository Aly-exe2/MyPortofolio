import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color navyColor = const Color(0xFF001F3F);
  final String link;
  const SocialMediaIconButton({super.key , required this.icon ,required this.iconColor , required this.link});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(icon, size: 30, color:iconColor),
      color: navyColor,
      onPressed: () async {
        await launchUrl(
            Uri.parse(link));
      },
    );
  }
}
