import 'package:flutter/material.dart';
import '../components/minimized_player.dart';
import '../services/audioService.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var audioPlayer = Provider.of<AudioService>(context);
    const String path = 'assets/decoration.svg';
    final Widget decoration = SvgPicture.asset(
      path,
      width: 60,
      height: 60,
    );
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 224, 204),
        body: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 100.0, bottom: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Aggragate",
                          style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0)),
                      const Text("& discover",
                          style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0)),
                      const Text("decentralized,",
                          style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              color: Colors.pink)),
                      Text("asynchronous",
                          style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              color: Colors.yellow[700])),
                      Text("high-volume",
                          style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              color: Colors.purple[200])),
                      const Text("content.",
                          style: TextStyle(
                              fontSize: 50.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const Divider(
                    color: Color.fromARGB(255, 134, 125, 93), thickness: 3.0),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 70.0,
                      height: 55.0,
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: Material(
                        type: MaterialType.transparency,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.black),
                          onPressed: () {
                            Navigator.pushNamed(context, '/podcast');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                MinimizedPlayer(
                  audioTitle: audioPlayer.audioTitle,
                  audioAuthor: audioPlayer.audioAuthor,
                )
              ],
            ),
            Positioned(
              bottom: 170,
              left: 25.0, // 25 units from the left edge.
              child: decoration,
            ),
          ],
        ));
  }
}
