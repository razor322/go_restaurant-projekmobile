import 'package:flutter/material.dart';
import 'package:go_restoran/const.dart';
import 'package:go_restoran/model/food/model_get_comment.dart';
import 'package:http/http.dart' as http;

class ListCommentPage extends StatefulWidget {
  final String id;
  const ListCommentPage(this.id, {super.key});

  @override
  State<ListCommentPage> createState() => _ListCommentPageState();
}

class _ListCommentPageState extends State<ListCommentPage> {
  bool isLoading = false;
  late List<Comment> _commentList = [];

  @override
  void initState() {
    super.initState();
    getComment();
  }

  Future<void> getComment() async {
    try {
      setState(() {
        isLoading = true;
      });
      final res = await http
          .get(Uri.parse('${url}get_comment.php?id_food=${widget.id!}'));
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
                  width: 100,
                ),
                Text(
                  "List Comment ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _commentList.length,
                itemBuilder: (context, index) {
                  Comment data = _commentList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black54)),
                      leading: Icon(Icons.person),
                      title: Text(data.username),
                      subtitle: Text(data.content),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
