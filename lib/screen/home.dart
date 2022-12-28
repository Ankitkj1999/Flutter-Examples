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
                  crossAxisCount: 1),
              itemCount: _photoModel!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Container(
                    child: Column(
                      children: [
                        Text(_photoModel![index].toString()),
                        // Image(
                        //   image: NetworkImage(_photoModel![index].thumbnailUrl),
                        //   fit: BoxFit.cover,
                        // ),
                        Text(_photoModel![index].title),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
