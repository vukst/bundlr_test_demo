import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBar extends StatelessWidget {
  final int likeCount;
  final int commentCount;
  final int viewCount;

  final Color darkBeige = const Color.fromARGB(255, 120, 110, 77);
  final Color lightBeige = const Color.fromARGB(255, 196, 172, 1);
  final Color darkSlateGray = const Color.fromARGB(255, 76, 73, 68);

  const BottomBar({
    super.key,
    required this.likeCount,
    required this.commentCount,
    required this.viewCount,
  });

  @override
  Widget build(BuildContext context) {
    const String folderPath = 'assets/folderplus.svg';
    final Widget folderPlus = SvgPicture.asset(
      folderPath,
      colorFilter: ColorFilter.mode(darkSlateGray, BlendMode.srcIn),
      width: 55,
      height: 55,
    );
    const String sharePath = 'assets/forward.svg';
    final Widget share = SvgPicture.asset(
      sharePath,
      colorFilter: ColorFilter.mode(darkSlateGray, BlendMode.srcIn),
      width: 55,
      height: 55,
    );
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: lightBeige, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.favorite_border, color: darkBeige),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text("$likeCount"),
                ),
                const SizedBox(width: 10),
                Icon(Icons.mode_comment_outlined, color: darkBeige),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text("$commentCount"),
                ),
                const SizedBox(width: 10),
                Icon(Icons.remove_red_eye_outlined, color: darkBeige),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text("$viewCount"),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    print("Folder tapped");
                  },
                  child: folderPlus,
                ),
                GestureDetector(
                  onTap: () {
                    print("Share tapped");
                  },
                  child: share,
                ),
                IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.more_vert, color: darkBeige),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
