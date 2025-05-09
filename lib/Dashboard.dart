import 'package:flutter/material.dart';
import 'package:day6_fitness/main.dart'; // Importa HomePage

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFC91441),
        toolbarHeight: 95,
        leadingWidth: 95,
        leading: IconButton(
          padding: EdgeInsets.zero,
          iconSize: 75,
          icon: Image.asset('assets/icons/Logo.png', fit: BoxFit.contain),
          onPressed: () {
            // Volver a HomePage con animación y fondo personalizado
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 600),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const HomePage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const backgroundColor = Color(0xFFC91441);
                  return Stack(
                    children: [
                      FadeTransition(
                        opacity: animation,
                        child: Container(color: backgroundColor),
                      ),
                      FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
        title: const SizedBox(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset('assets/icons/Carrito.png', height: 40),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset('assets/icons/Menu.png', height: 40),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Banner superior
                    Container(
                      color: const Color(0xFF55091C),
                      height: 55,
                      alignment: Alignment.center,
                      child: const Text(
                        '¿No tienes cuenta? ¡Registrate!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontFamily: 'CarterOne',
                        ),
                      ),
                    ),
                    // Imagen de promoción
                    Image.asset('assets/images/Promocion.png',
                        fit: BoxFit.cover),
                    // Banner "Lo más vendido"
                    Container(
                      color: const Color(0xFF55091C),
                      height: 55,
                      alignment: Alignment.center,
                      child: const Text(
                        '¡Lo más vendido!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontFamily: 'CarterOne',
                        ),
                      ),
                    ),
                    // Menú con fondo y items
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Bas.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              MenuItem(
                                imagePath: 'assets/images/Cheesecake.png',
                                label: 'Cheese Cake',
                              ),
                              MenuItem(
                                imagePath: 'assets/images/Perro.png',
                                label: 'Perro Pastel',
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const _WhiteBar(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WhiteBar extends StatelessWidget {
  const _WhiteBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String imagePath;
  final String label;

  const MenuItem({Key? key, required this.imagePath, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 139,
          height: 139,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Center(
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'CarterOne',
          ),
        ),
      ],
    );
  }
}
