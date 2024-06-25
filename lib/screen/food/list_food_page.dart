import 'package:flutter/material.dart';
import 'package:go_restoran/const.dart';
import 'package:go_restoran/model/food/model_get_food.dart';
import 'package:go_restoran/screen/food/detail_food_page.dart';
import 'package:http/http.dart' as http;

class ListFoodPage extends StatefulWidget {
  const ListFoodPage({super.key});

  @override
  State<ListFoodPage> createState() => _ListFoodPageState();
}

class _ListFoodPageState extends State<ListFoodPage> {
  bool isLoading = false;
  late List<Food> _productList = [];
  TextEditingController txtcari = TextEditingController();
  late List<Food> _searchResult = [];
  @override
  void initState() {
    super.initState();
    getProduct();
  }

  Future<void> getProduct() async {
    try {
      setState(() {
        isLoading = true;
      });
      final res = await http.get(Uri.parse('${url}get_food.php'));

      if (res.statusCode == 200) {
        final modelProduct = modelGetFoodFromJson(res.body);
        setState(() {
          _productList = modelProduct.foods ?? [];
          _searchResult = modelProduct.foods ?? [];
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
    List<Food> filteredProducts = _productList
        .where((produk) =>
            produk.name!.toLowerCase().contains(query.toLowerCase()))
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
                  "List Food",
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
                childAspectRatio: 0.87, // Optional: Adjust aspect ratio
              ),
              itemBuilder: (context, index) {
                Food data = _searchResult[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailFoodPage(data)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Container(
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              height: 180,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  '${urlImg}${data.image}', // Assuming Product has an imageUrl field
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              data.name,
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
