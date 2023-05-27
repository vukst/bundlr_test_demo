import 'package:flutter/material.dart';
import '../components/player.dart';
import '../components/top_bar.dart';
import '../components/bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PodcastPage extends StatefulWidget {
  final String id;
  final String accessToken;

  const PodcastPage({
    Key? key,
    required this.id,
    required this.accessToken,
  }) : super(key: key);

  @override
  _PodcastPageState createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  String audioFile = '';
  String audioCover = '';
  String contentType = '';
  String title = '';
  String summary = '';
  String author = '';
  int likeCount = 0;
  int commentCount = 0;
  int viewCount = 0;
  bool isExpanded = false;
  final Color darkBrown = const Color.fromARGB(255, 107, 96, 61);

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var url = Uri.parse(
        'https://development-backend-rest-api-dot-bundlr-beta.uw.r.appspot.com/api/episodes/${widget.id}');
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer ${widget.accessToken}"},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        audioFile = data['mp3_url'];
        audioCover = data['image'];
        contentType = data['ko_type'];
        summary = data['summary'];
        author = data['author'];
        title = data['title'];
        likeCount = data['upvotes_count'];
        commentCount = data['comments_count'];
      });
    } else {
      print('Failed to load data');
    }
  }

  @override
  void didUpdateWidget(PodcastPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var summaryWords = summary.split(" ");
    var trimmedSummary = isExpanded
        ? summary
        : summaryWords
            .sublist(0, summaryWords.length > 30 ? 30 : summaryWords.length)
            .join(" ");

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 240, 230),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: CustomTopBar(
            contentType: 'podcast',
            source: author,
          ),
        ),
        body: Scaffold(
          backgroundColor: Colors.transparent,
          body: audioFile != ''
              ? Column(
                  children: <Widget>[
                    CustomAudioPlayer(
                      audioFile: audioFile,
                      audioCover: audioCover,
                      audioTitle: title,
                      audioAuthor: author,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                trimmedSummary,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Text(
                                  isExpanded ? "Show less" : "Show more",
                                  style: TextStyle(
                                    color: darkBrown,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          bottomNavigationBar: BottomBar(
            likeCount: likeCount,
            commentCount: commentCount,
            viewCount: 0,
          ),
        ),
      ),
    );
  }
}
