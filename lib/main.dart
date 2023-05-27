import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pages/landing_page.dart';
import 'pages/podcast_page.dart';
import '../services/audioService.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AudioService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String accessToken = '';

  @override
  void initState() {
    super.initState();
    _getAccessToken();
  }

  Future<void> _getAccessToken() async {
    if (accessToken.isEmpty) {
      var url = Uri.parse(
          'https://development-backend-rest-api-dot-bundlr-beta.uw.r.appspot.com/api/auth');
      var response = await http.post(url, body: {
        'username': 'user3@email.com',
        'password': 'Password123!',
      });

      if (response.statusCode == 200) {
        setState(() {
          accessToken = json.decode(response.body)['access_token'];
        });
      } else {
        throw Exception('Failed to load token');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Moderat'),
      title: 'Flutter Demo',
      routes: {
        '/': (context) => const LandingPage(),
        '/podcast': (context) => PodcastPage(
              id: '51243198-d2d0-4fb6-babc-02d6873dd4c7',
              accessToken: accessToken,
            ),
      },
    );
  }
}
