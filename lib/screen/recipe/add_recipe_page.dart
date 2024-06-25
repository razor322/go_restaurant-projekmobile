import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_restoran/const.dart';
import 'package:go_restoran/model/model_massage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  XFile? _image;
  String? id;
  final picker = ImagePicker();
  TextEditingController nama = TextEditingController();
  TextEditingController ingredient = TextEditingController();
  TextEditingController recipe_name = TextEditingController();

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getSession();
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

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      print('id user $id');
    });
  }

  Future<void> addRecipe() async {
    try {
      setState(() {
        isLoading = true;
      });

      var stream = http.ByteStream(DelegatingStream.typed(_image!.openRead()));
      var length = await _image!.length();
      var uri = Uri.parse('${url}add_recipe.php');
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile(
        "image",
        stream,
        length,
        filename: path.basename(_image!.path),
      );

      request.fields['id_user'] = id!;
      request.fields['ingredient'] = ingredient.text;
      request.files.add(multipartFile);
      request.fields['recipe_name'] = recipe_name.text;
      print(id);
      print(ingredient.text);
      print(recipe_name.text);
      print(multipartFile);
      var response = await request.send();
      // print(response);

      // Read the response stream once and store it in a variable
      var responseBody = await response.stream.bytesToString();
      print(responseBody);

      // Now you can use responseBody multiple times without issues
      if (response.statusCode == 200) {
        ModelMassage data = modelMassageFromJson(responseBody);
        if (data.value == 1) {
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${data.message}')));
          });

          Navigator.pop(context);
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
        print(e.toString());
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
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
        title: Text(
          "Tambah Resep",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: keyForm,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      _pilihGallery();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 150.0,
                      child: _image == null
                          ? placeholder
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
                    controller: recipe_name,
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    decoration: InputDecoration(
                        labelText: "Nama Resep",
                        hintText: "Nama Resep",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.blue.shade300),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: ingredient,
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    maxLines: 8,
                    decoration: InputDecoration(
                        labelText: "Bahan bahan",
                        hintText: "Bahan bahan",
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
                  SizedBox(
                    height: 16,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      if (keyForm.currentState?.validate() == true) {
                        addRecipe();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("silahkan isi data terlebih dahulu")));
                      }
                    },
                    color: Colors.blue,
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
