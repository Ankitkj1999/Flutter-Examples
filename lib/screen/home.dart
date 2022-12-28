import 'dart:ui';

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../modal/photo_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<PhotoModel>? _photoModel = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _photoModel = (await ApiServices().getPhotos())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    var orientation;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('REST API Example')),
      ),
      body: _photoModel == null || _photoModel!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: _photoModel!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Color.fromARGB(255, 255, 235, 171),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        Text(_photoModel![index].id.toString()),
                        const SizedBox(
                          height: 5,
                        ),
                        Image(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.1,
                          image: NetworkImage(
                              "https://picsum.photos/id/${_photoModel![index].id}/200/300"),
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _photoModel![index].title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
