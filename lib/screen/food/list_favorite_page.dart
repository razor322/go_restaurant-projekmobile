import 'package:flutter/material.dart';
import 'package:go_restoran/const.dart';
import 'package:go_restoran/model/fav/model_get_fav.dart';
import 'package:go_restoran/model/food/model_get_food.dart';
import 'package:go_restoran/screen/food/detail_fav.dart';
import 'package:go_restoran/screen/food/detail_food_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ListFavoriteFoodPage extends StatefulWidget {
  const ListFavoriteFoodPage({super.key});

  @override
  State<ListFavoriteFoodPage> createState() => _ListFavoriteFoodPageState();
}

class _ListFavoriteFoodPageState extends State<ListFavoriteFoodPage> {
  bool isLoading = false;
  late List<Favorite> _productList = [];
  TextEditingController txtcari = TextEditingController();
  late List<Favorite> _searchResult = [];
  String? id;

  @override
  void initState() {
    super.initState();
    getSession().then((value) => getProduct());
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      print('id user $id');
    });
  }

  Future<void> getProduct() async {
    try {
      setState(() {
        isLoading = true;
      });
      final res =
          await http.get(Uri.parse('${url}get_favorite.php?user_id=$id'));
      print(res.body);

      if (res.statusCode == 200) {
        List<Favorite> data = modelGetFavFromJson(res.body).favorites ?? [];
        setState(() {
          _productList = data;
          _searchResult = data;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed Load data')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _filterBerita(String query) {
    List<Favorite> filteredProducts = _productList
        .where((produk) =>
            produk.foodName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _searchResult = filteredProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
                SizedBox(
                  width: 110,
                ),
                Text(
                  "List Food Favorite",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: _filterBerita,
              controller: txtcari,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: Colors.orange.shade100,
                hintText: "Search",
                hintStyle: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: _searchResult.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.87,
              ),
              itemBuilder: (context, index) {
                Favorite data = _searchResult[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailFavPage(data)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Container(
                      child: Column(
                        children: [
                          // Center(
                          //   child: Container(
                          //     height: 180,
                          //     child: ClipRRect(
                          //       borderRadius: BorderRadius.circular(20),
                          //       child: Image.network(
                          //         '${urlImg}${data.}', // Assuming Product has an imageUrl field
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              data.foodName!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
