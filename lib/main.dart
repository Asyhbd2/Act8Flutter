import 'package:flutter/material.dart';
import 'package:day6_fitness/Dashboard.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(const MyApp());

/// Ahora tenemos un MyApp que envuelve tu HomePage
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Cereza',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  PageController? _pageController;
  AnimationController? rippleController;
  AnimationController? scaleController;
  Animation<double>? rippleAnimation;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: const Dashboard()),
          );
        }
      });

    rippleAnimation =
        Tween<double>(begin: 80.0, end: 90.0).animate(rippleController!)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              rippleController?.reverse();
            } else if (status == AnimationStatus.dismissed) {
              rippleController?.forward();
            }
          });

    scaleAnimation =
        Tween<double>(begin: 1.0, end: 30.0).animate(scaleController!);

    rippleController?.forward();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    rippleController?.dispose();
    scaleController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          makePage(image: 'assets/images/Fondo2.png'),
        ],
      ),
    );
  }

  Widget makePage({required String image}) {
    return SingleChildScrollView(
      // Esto permite scroll vertical si el contenido es más alto que la pantalla
      physics: const BouncingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        // Ocupamos al menos la altura de la pantalla
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.3),
                Colors.black.withOpacity(.2),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              // Ocupamos todo el espacio vertical disponible
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Cabecera de texto
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(height: 60),
                    Text(
                      'Bienvenido\nA la Cereza',
                      style: TextStyle(
                          color: Color(0xff3ff800),
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'CarterOne'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '¡Con la siguiente app estaras en una aplicacion para comprar postres y decoracion!',
                      style: TextStyle(
                        color: Color(0xff3ff800),
                        fontSize: 18,
                        height: 1.4,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'CarterOne',
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),

                // Botón de fingerprint con animaciones
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedBuilder(
                    animation: rippleAnimation!,
                    builder: (context, child) => Container(
                      width: rippleAnimation!.value,
                      height: rippleAnimation!.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(.4),
                      ),
                      child: InkWell(
                        onTap: () => scaleController?.forward(),
                        child: AnimatedBuilder(
                          animation: scaleAnimation!,
                          builder: (context, child) => Transform.scale(
                            scale: scaleAnimation!.value,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff3ff800),
                              ),
                              child: scaleController!.status ==
                                          AnimationStatus.forward ||
                                      scaleController!.status ==
                                          AnimationStatus.completed
                                  ? null
                                  : const Center(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
