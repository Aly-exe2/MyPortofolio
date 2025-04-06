import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portofoli/widgets/social_media_icon_button.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaIconButton(
          icon: FontAwesomeIcons.github,
          iconColor: Colors.grey,
          link: "https://github.com/Aly-exe",
        ),
        SocialMediaIconButton(
          icon: FontAwesomeIcons.linkedin,
          iconColor: Colors.blue,
          link:
              "https://www.linkedin.com/in/ali-sayed-8a8b81220/",
        ),
        SocialMediaIconButton(
          icon: FontAwesomeIcons.facebook,
          iconColor: Colors.blue,
          link:
              "https://www.facebook.com/profile.php?id=100026765389745",
        ),
        SocialMediaIconButton(
          icon: FontAwesomeIcons.instagram,
          iconColor: Colors.redAccent,
          link: "https://www.instagram.com/3liisayed/",
        ),
        SocialMediaIconButton(
          icon: FontAwesomeIcons.whatsapp,
          iconColor: Colors.green,
          link: "https://wa.me/+201018961447",
        ),
        SocialMediaIconButton(
          icon: FontAwesomeIcons.fileLines,
          iconColor: Colors.black87,
          link:
              "https://drive.google.com/file/d/1XB2UP3P81UIyk68rsrpNzoaoEhr1nmIH/view?usp=drive_link",
        ),
      ],
    );
  }
}
