import 'dart:ui';

import 'package:flutter/material.dart';
import '../services/api_servicel.dart';
import '../model/user_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<UserModel>? _userModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('REST API Example')),
      ),
      body: _userModel == null || _userModel!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _userModel!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    tileColor: Color.fromARGB(255, 230, 230, 230),
                    leading: Text(
                      _userModel![index].id.toString(),
                    ),
                    title: Text(
                      _userModel![index].username,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: Text(_userModel![index].phone),
                    subtitle: Text(_userModel![index].email),
                  ),
                );
                // Card(
                //   child: Column(
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           Text(_userModel![index].id.toString()),
                //           Text(_userModel![index].username),
                //         ],
                //       ),
                //       const SizedBox(
                //         height: 20.0,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           Text(_userModel![index].email),
                //           Text(_userModel![index].website),
                //         ],
                //       ),
                //     ],
                //   ),
                // );
              },
            ),
    );
  }
}
