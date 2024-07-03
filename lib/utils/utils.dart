import 'package:flutter/material.dart';
import 'package:folio/sections/about/about.dart';
import 'package:folio/sections/contact/contact.dart';
import 'package:folio/sections/home/home.dart';
import 'package:folio/sections/portfolio/portfolio.dart';
import 'package:folio/sections/services/services.dart';
import 'package:folio/widget/footer.dart';

class StaticUtils {
  static const String hi = 'assets/hi.gif';

  // photos
  static const String mobilePhoto = 'assets/photos/colored.png';
  static const String coloredPhoto = 'assets/photos/colored.png';
  static const String blackWhitePhoto = 'assets/photos/black-white.png';

  // work;
  static const String university = 'assets/work/cruzeiro-do-sul.png';
  static const String work = 'assets/work/netsys.png';

  // services
  static const String ti = 'assets/services/ti.png';
  static const String code = 'assets/services/code.png';
  static const String design = 'assets/services/design.png';

  static const List<String> socialIconURL = [
    "https://img.icons8.com/ios-filled/100/telegram.png",
    "https://img.icons8.com/ios-filled/100/instagram-new--v1.png",
    "https://img.icons8.com/ios-filled/100/linkedin.png",
    "https://img.icons8.com/ios-filled/100/github.png",
  ];

  static const List<String> socialLinks = [
    "https://t.me/hendril_mendes",
    "https://instagram.com/hendril_mendes",
    "https://linkedin.com/in/hendril-mendes",
    "https://github.com/hendrilmendes",
  ];

  static const String resume =
      'https://1drv.ms/b/s!Ahw1Ik4ugCxajaI09DxcBh5vPl99hg?e=j0CyXz';

  static const String certificado =
      'https://1drv.ms/f/s!Ahw1Ik4ugCxahttb0dkI6c0XduBd1w?e=QZ22nf';

  static const String gitHub = 'https://github.com/hendrilmendes?tab=repositories';
}

class BodyUtils {
  static const List<Widget> views = [
    HomePage(),
    About(),
    Services(),
    Portfolio(),
    Contact(),
    Footer(),
  ];
}
