import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                width: 300,
                height: 90,
                child: Image.asset(
                  'assets/logo2.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "About Us",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                " Kami adalah para pecinta masakan tradisional yang menghadirkan cita rasa autentik kampung halaman ke meja makan Anda. Dengan berbagai pengalaman dalam memasak, kami menyajikan resep-resep khas kampung halaman, terutama dari warisan budaya Minangkabau. Kami percaya bahwa makanan adalah tentang merayakan warisan budaya dan setiap hidangan kami sarat dengan cerita. Kami siap memberikan pengalaman kuliner tak terlupakan kepada Anda dengan setiap suapan. Temukan kelezatan autentik dengan GoRestaurant!",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                " Location at \nJl. Kampus, Limau Manis, Padang, Sumatera Barat Contact at: 0812345678",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
