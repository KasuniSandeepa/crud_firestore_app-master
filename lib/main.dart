import 'package:animated_background/animated_background.dart';
import 'package:crud_firestore_app/screens/generation/animation_test.dart';
import 'package:crud_firestore_app/screens/item_list.dart';
import 'package:crud_firestore_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  ParticleOptions particleOptions = ParticleOptions(
    image: Image.asset('assets/family.png',height: 100, width: 200),
    //baseColor: Colors.blue,
    spawnOpacity: 0.0,
    opacityChangeRate: 1.25,
    minOpacity: 0.7,
    maxOpacity: 0.9,
    spawnMinSpeed: 30.0,
    spawnMaxSpeed: 70.0,
    spawnMinRadius: 7.0,
    spawnMaxRadius: 15.0,
    particleCount: 50,);
  var particlePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.lightBlueAccent,
        backgroundColor: Color.fromRGBO(108, 199, 235, 1),

        body:
        Container(
          height: size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue,Colors.white])),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/main_top.png",
                  width: size.width * 0.3,
                ),
              ),
              Container(
                child: Image.asset(
                  "assets/family.png",
                  width: size.width * 3,

                ),
              ),
              Positioned(
                child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/blood_line_black.png"),
                          //fit: BoxFit.cover,
                        ))
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "assets/login_bottom.png",
                  width: size.width * 0.4,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>LoginScreen()
                    ),
                  );
                },
              ),
            ],
          ),
        )
    );
  }
}