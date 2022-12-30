import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:torch_light/torch_light.dart';
import '../widgets.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Flash Light App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Oxygen",
      ),
      home: const Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool isFlashOn = true;
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode
            ? const Color.fromARGB(255, 245, 245, 245)
            : const Color.fromARGB(255, 24, 24, 24),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            "Flashy",
            style: TextStyle(
                color: isDarkMode ? Colors.black : Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: Container(
                  width: w / 8.5,
                  height: h / 17.5,
                  child: isDarkMode
                      ? Image(image: AssetImage("assets/images/light_on.png"))
                      : Image(image: AssetImage("assets/images/light_off.png")),
                ),
                bottom: h / 1.5,
              ),
              Positioned(
                child: DayNightSwitcher(
                  starsColor: Colors.transparent,
                  cloudsColor: Colors.transparent,
                  isDarkModeEnabled: isFlashOn,
                  onStateChanged: (val) {
                    setState(() {
                      isFlashOn = val;
                      isDarkMode = !isDarkMode;
                    });
                    isFlashOn ? _turnOffFlash(context) : _turnOnFlash(context);
                  },
                ),
                bottom: h / 2.2,
              ),
              Positioned(
                bottom: h / 7.5,
                child: Text(
                  "Made By Ankit Kumar",
                  style: TextStyle(
                      color: isDarkMode ? Colors.black : Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Positioned(
                  bottom: 20,
                  child: SizedBox(
                    width: w / 1.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        bottomSocial(
                            img: 'assets/images/gmail.png',
                            url: "https://ankit.k.j1999@gmail.com",
                            context: context,
                            isDarkMode: isDarkMode),
                        bottomSocial(
                            img: 'assets/images/twitter.png',
                            url: "https://twitter.com/ankitkj1999",
                            context: context,
                            isDarkMode: isDarkMode),
                        bottomSocial(
                            img: 'assets/images/linkedin.png',
                            url: "https://www.linkedin.com/in/ankitkj1999/",
                            context: context,
                            isDarkMode: isDarkMode),
                        bottomSocial(
                            img: 'assets/images/github.png',
                            url: "https://github.com/ankitkj1999",
                            context: context,
                            isDarkMode: isDarkMode),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _turnOnFlash(BuildContext context) async {
  try {
    await TorchLight.enableTorch();
  } on Exception catch (_) {
    _showErrorMessage("Could not enable Flashlight", context);
  }
}

Future<void> _turnOffFlash(BuildContext context) async {
  try {
    await TorchLight.disableTorch();
  } on Exception catch (_) {
    _showErrorMessage("Could not enable Flashlight", context);
  }
}

void _showErrorMessage(String mes, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mes)));
}
