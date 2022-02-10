import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const bannerHeight = 220.0;
const bannerImageWidth = 120.0;
const bannerImageRight = 10.0;
const bannerBgHeight = 60.0;
const bigTileHeight = 246.0;
const tileSpacing = 16.0;
const iconPad = 12.0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setDefaults(<String, dynamic>{
    "colorScheme": jsonEncode({
      "primary": 0xFF6200EE,
      "primaryVariant": 0xFF3700B3,
      "secondary": 0xFF03DAC6,
      "secondaryVariant": 0xFF018786,
      "surface": 0xFFFFFFFF,
      "background": 0xFFFFFFFF,
      "error": 0xFFB00020,
      "onPrimary": 0xFFFFFFFF,
      "onSecondary": 0xFF000000,
      "onSurface": 0xFF000000,
      "onBackground": 0xFF000000,
      "onError": 0xFFffffff,
    })
  });

  //Set fetch interval to 1 minutes and call fetch so we can see the changes immediately
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: const Duration(minutes: 1),
  ));
  await remoteConfig.fetchAndActivate();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    final colorScheme = jsonDecode(remoteConfig.getString("colorScheme"));
    return MaterialApp(
      title: 'Theming Demo',
      theme: ThemeData.from(
          colorScheme: ColorScheme(
              primary: Color(colorScheme["primary"]),
              primaryVariant: Color(colorScheme["primaryVariant"]),
              secondary: Color(colorScheme["secondary"]),
              secondaryVariant: Color(colorScheme["secondaryVariant"]),
              surface: Color(colorScheme["surface"]),
              background: Color(colorScheme["background"]),
              error: Color(colorScheme["error"]),
              onPrimary: Color(colorScheme["onPrimary"]),
              onSecondary: Color(colorScheme["onSecondary"]),
              onSurface: Color(colorScheme["onSurface"]),
              onBackground: Color(colorScheme["onBackground"]),
              onError: Color(colorScheme["onError"]),
              brightness: Brightness.light)),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor = HSLColor.fromColor(Theme.of(context).primaryColor)
        .withSaturation(0.3)
        .toColor();

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.bars,
                    color: iconColor,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox.square(
                        dimension: 55.0,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            shape: BoxShape.circle,
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.search,
                            color: iconColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      SizedBox.square(
                        dimension: 55.0,
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/profile.jpg"),
                                fit: BoxFit.cover,
                              )),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 12.0),
              Text(
                "Hello",
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                "Akosua K.",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: iconColor),
              ),
              SizedBox(
                height: bannerHeight,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: bannerHeight - bannerBgHeight,
                        child: Container(
                          width: double.maxFinite,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(8.0)),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0.0,
                        right: bannerImageRight,
                        child: SizedBox(
                          height: bannerHeight,
                          width: bannerImageWidth,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/midwife.png"),
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                        )),
                    Positioned(
                      bottom: 0.0,
                      child: SizedBox(
                        height: bannerHeight - bannerBgHeight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "50% off",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      fontSize: 24.0),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  "take any courses",
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                          .withOpacity(0.85)),
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30.0))),
                                  child: Text(
                                    "Join Now",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "Find your job",
                style: TextStyle(fontSize: 18.0, color: iconColor),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: bigTileHeight,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(iconPad),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.paperPlane,
                                  color: iconColor,
                                ),
                              ),
                              const SizedBox(height: iconPad),
                              const Text(
                                "34.3k",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Remote jobs",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: tileSpacing),
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              color:
                                  Theme.of(context).colorScheme.primaryVariant),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(iconPad),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.building,
                                    color: iconColor,
                                  ),
                                ),
                                const SizedBox(width: iconPad),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "24.1k",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Full time",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                        const SizedBox(height: tileSpacing),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            color:
                                Theme.of(context).colorScheme.secondaryVariant,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(iconPad),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.heart,
                                    color: iconColor,
                                  ),
                                ),
                                const SizedBox(width: iconPad),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "12.9k",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Part time",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
