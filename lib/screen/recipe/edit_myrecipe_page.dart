// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_restoran/components/bottom_navigation.dart';
import 'package:go_restoran/const.dart';
import 'package:go_restoran/model/model_massage.dart';
import 'package:go_restoran/model/recipe/model_myrecipe.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uts_mobile_app/models/model_update_Sejarah.dart';

class EditMyRecipePage extends StatefulWidget {
  final dynamic data;
  EditMyRecipePage(this.data, {super.key});

  @override
  State<EditMyRecipePage> createState() => _EditMyRecipePageState();
}

class _EditMyRecipePageState extends State<EditMyRecipePage> {
  TextEditingController upnama = TextEditingController();
  TextEditingController upingredient = TextEditingController();
  TextEditingController uprecipe_name = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;
  String? id;
  XFile? _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
    upnama = TextEditingController(text: widget.data?.recipeName);
    upingredient = TextEditingController(text: widget.data?.ingredient);
    ;
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      print('id user $id');
    });
  }

  _pilihGallery() async {
    var image = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _image = image;
    });
  }

  _pilihCamera() async {
    var image = await ImagePicker().pickImage(
        source: ImageSource.camera, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _image = image;
    });
  }

  Future<void> editRecipe() async {
    try {
      setState(() {
        isLoading = true;
        print(id);
      });
      var stream = http.ByteStream(DelegatingStream.typed(_image!.openRead()));
      var length = await _image!.length();
      var uri = Uri.parse('${url}edit_recipe.php');
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile(
        "image",
        stream,
        length,
        filename: path.basename(_image!.path),
      );

      request.fields['id_user'] = id!;
      request.fields['id_recipe'] = widget.data!.idRecipe;
      request.fields['recipe_name'] = upnama.text;
      request.files.add(multipartFile);
      request.fields['ingredient'] = upingredient.text;

      // Pastikan respons adalah JSON yang valid sebelum mengurai
      print("id $id");
      print("recipe id $widget.data!.idRecipe");
      var response = await request.send();
      print(response);

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        print(jsonResponse);
        ModelMassage data = ModelMassage.fromJson(jsonResponse);

        if (data.value == 1) {
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${data.message}')));
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BotNav()),
              (route) => false);
        } else {
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${data.message}')));
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        print(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var placeholder = Container(
      width: double.infinity,
      height: 150,
      child: Image.asset('./assets/placeholder.png'),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data Sejarah"),
        backgroundColor: Colors.purple.shade200,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: keyForm,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // _pilihCamera();
                      _pilihGallery();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 150.0,
                      child: _image == null
                          ? Image.network(
                              '$urlImg${widget.data?.image}',
                              fit: BoxFit.fill,
                            )
                          : Image.file(
                              File(_image!.path),
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: upnama,
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    decoration: InputDecoration(
                        labelText: "Recipe Name",
                        hintText: "Recipe Name",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.blue.shade300),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    maxLines: 8,
                    controller: upingredient,
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    decoration: InputDecoration(
                        labelText: "Ingredient",
                        hintText: "Ingredient",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.blue.shade300),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () async {
                      if (keyForm.currentState?.validate() == true) {
                        await editRecipe(); // Tunggu hingga operasi selesai

                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => SejarahPage()),
                        //   (route) => false,
                        // );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Silahkan isi data terlebih dahulu"),
                          ),
                        );
                      }
                    },
                    color: Colors.purple.shade400,
                    textColor: Colors.white,
                    height: 45,
                    child: const Text("Submit"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
