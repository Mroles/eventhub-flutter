import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventhub/globals.dart';
import 'package:eventhub/providers/imageprovider.dart';
import 'package:eventhub/providers/locationprovider.dart';
import 'package:eventhub/providers/loginprovider.dart';
import 'package:eventhub/screens/chat.dart';
import 'package:eventhub/screens/createpost.dart';
import 'package:eventhub/screens/login.dart';
import 'package:eventhub/screens/maps.dart';
import 'package:eventhub/screens/post.dart';
import 'package:eventhub/screens/profile.dart';
import 'package:eventhub/screens/splash.dart';
import 'package:eventhub/screens/testlogin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

final imageProv = ImageProv();
final bucketGlobal = PageStorageBucket();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ByteData data =
  //     await rootBundle.load('assets/certificates/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());
  HttpOverrides.global = new MyHttpOverrides();
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => LoadingProvider(),
      ),
      ChangeNotifierProvider(create: (_) => LoginLoadProvider()),
      ChangeNotifierProvider(
        create: (_) => ImageProv(),
      ),
      ChangeNotifierProvider(create: (_) => LocationProvider())
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          colorScheme: ColorScheme.fromSwatch().copyWith(
              brightness: Brightness.light,
              primary: primaryColorLight,
              secondary: secondaryColorLight)),
      // home: const MyHomePage(
      //   title: 'EventHub',
      // ),
      // home: MyHomePage(title: "EventHub"),
      home: PostPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 1;

  final screens = [
    ChatPage(),
    PostPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = <Widget>[
      const Icon(Icons.chat),
      const Icon(Icons.home),
      const Icon(Icons.person)
    ];

    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: index == 0
              ? const Text("Chat")
              : index == 1
                  ? const Text("Events")
                  : const Text("Profile"),
          backgroundColor: Colors.white.withOpacity(0.25),
          centerTitle: true,
          elevation: 0,
        ),
        body: PageStorage(bucket: bucketGlobal, child: screens[index]),
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
          child: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: Colors.orange,
            items: items,
            height: 60,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            index: index,
            onTap: (index) => setState(() => this.index = index),
          ),
        ));
  }
}
