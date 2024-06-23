import 'package:flutter/material.dart';
import 'package:go_restoran/const.dart';
import 'package:go_restoran/model/fav/model_get_fav.dart';
import 'package:go_restoran/model/food/model_get_food.dart';
import 'package:go_restoran/model/model_massage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailFavPage extends StatefulWidget {
  final Favorite? data;
  const DetailFavPage(this.data, {super.key});

  @override
  State<DetailFavPage> createState() => _DetailFavPageState();
}

class _DetailFavPageState extends State<DetailFavPage> {
  String? id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      print('id user $id');
    });
  }

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Container(
            //   height: 440,
            //   child: Center(
            //     child: Container(
            //       height: 330,
            //       child: Image.network(
            //         '${urlImg}${widget.data!.image}',
            //         fit: BoxFit.fill,
            //         loadingBuilder: (BuildContext context, Widget child,
            //             ImageChunkEvent? loadingProgress) {
            //           if (loadingProgress == null) return child;
            //           return Center(
            //             child: CircularProgressIndicator(
            //               value: loadingProgress.expectedTotalBytes != null
            //                   ? loadingProgress.cumulativeBytesLoaded /
            //                       (loadingProgress.expectedTotalBytes ?? 1)
            //                   : null,
            //             ),
            //           );
            //         },
            //         errorBuilder: (BuildContext context, Object error,
            //             StackTrace? stackTrace) {
            //           return Text('Image failed to load');
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    "Detail Product",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 350),
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data!.foodName,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.favorite_outline_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        widget.data!.foodDescription,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 3, color: Colors.green),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.person,
                              color: Colors.green,
                              size: 22,
                            ),
                          ),
                        ),
                        title: Text(
                          widget.data!.foodName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
