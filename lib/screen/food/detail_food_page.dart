import 'package:flutter/material.dart';
import 'package:go_restoran/const.dart';
import 'package:go_restoran/model/fav/model_get_fav.dart';
import 'package:go_restoran/model/food/model_get_comment.dart';
import 'package:go_restoran/model/food/model_get_food.dart';
import 'package:go_restoran/model/model_massage.dart';
import 'package:go_restoran/model/model_succes.dart';
import 'package:go_restoran/screen/food/list_comment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailFoodPage extends StatefulWidget {
  final dynamic data;
  const DetailFoodPage(this.data, {super.key});

  @override
  State<DetailFoodPage> createState() => _DetailFoodPageState();
}

class _DetailFoodPageState extends State<DetailFoodPage> {
  String? id;
  bool isLoading = false;
  late List<Comment> _commentList = [];
  bool isFavorite = false;
  final _formKeyComment = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
    getComment();
    checkIfFavorite();
  }

  Food get _productData {
    if (widget.data is Food) {
      return widget.data;
    } else if (widget.data is Favorite) {
      final favorite = widget.data as Favorite;
      return Food(
          idFood: favorite.idFood.toString(),
          name: favorite.foodName,
          description: favorite.foodDescription,
          image: favorite.image,
          idStore: '',
          storeName: favorite.storeName,
          location: favorite.location,
          createdAt: favorite.createdAt,
          updatedAt: favorite.updatedAt);
    }
    throw Exception("Invalid data type");
  }

  void checkIfFavorite() {
    if (widget.data is Favorite) {
      setState(() {
        isFavorite = true;
      });
    } else {
      setState(() {
        isFavorite = false;
      });
    }
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      print('id user $id');
    });
  }

  Future<void> getComment() async {
    try {
      setState(() {
        isLoading = true;
      });
      final res = await http.get(
          Uri.parse('${url}get_comment.php?id_food=${widget.data!.idFood}'));
      print(res.body);
      if (res.statusCode == 200) {
        final modelGetComment = modelGetCommentFromJson(res.body);
        setState(() {
          _commentList = modelGetComment.comments ?? [];
          // Sort comments by date in descending order
          _commentList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed Load data')),
        );
      }
    } catch (e) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> addComment(String idfood, String comment) async {
    if (_formKeyComment.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        setState(() {
          isLoading = true;
        });
        final res = await http.post(Uri.parse('${url}add_comment.php'),
            body: {"id_user": id, "id_food": idfood, "content": comment});
        print(res.body);
        if (res.statusCode == 200) {
          final modelSuccess = modelSuccesFromJson(res.body);
          print(modelSuccess);
          setState(() {
            getComment();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed Load data')),
          );
        }
      } catch (e) {
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(e.toString())));
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final data = _productData;
    Future<void> addFav(String idp, String idStore) async {
      try {
        http.Response res = await http.post(Uri.parse('${url}add_favorite.php'),
            body: {"user_id": id, "food_id": idp, "store_id": idStore});
        print(res.body);
        if (res.statusCode == 200) {
          ModelMassage data = modelMassageFromJson(res.body);

          if (data.value == 1) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}')),
            );
          }
        }
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('gagal menambahkan data')),
        );
      }
    }

    void _showCommentDialog() {
      TextEditingController comment = TextEditingController();

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Form(
                key: _formKeyComment,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      "Comment",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: comment,
                      decoration: InputDecoration(
                        hintText: 'comment ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Color(0xFF67729429),
                            width: 1,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            print(comment.text);
                            if (_formKeyComment.currentState!.validate()) {
                              print(id);
                              addComment(data.idFood, comment.text);
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(
                                0xFFFFC107), // Color of the confirm button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: Size(295, 54),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 440,
              child: Center(
                child: Container(
                  height: 330,
                  child: Image.network(
                    '${urlImg}${widget.data!.image}',
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Text('Image failed to load');
                    },
                  ),
                ),
              ),
            ),
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
                    "Detail Product ",
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
                              data!.name,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _showCommentDialog();
                                  },
                                  icon: Icon(
                                    Icons.chat_bubble_outline,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                                IconButton(
                                  onPressed: isFavorite
                                      ? null // Disable the onPressed action if the item is already a favorite
                                      : () {
                                          setState(() {
                                            isFavorite = true;
                                          });
                                          addFav(_productData.idFood,
                                              _productData.idStore);
                                        },
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        data.description,
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
                          data!.storeName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Comment",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ListCommentPage(data.idFood)));
                              },
                              child: Text("See all",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 130,
                        child: _commentList.isEmpty
                            ? Center(child: Text("No comments available"))
                            : ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  Comment data = _commentList[index];
                                  return ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text(
                                        data.username ?? 'No comment text'),
                                    subtitle: Text(data.content),
                                  );
                                },
                              ),
                      )
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
