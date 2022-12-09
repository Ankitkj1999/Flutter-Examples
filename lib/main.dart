import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FireStoreApp());
}

class FireStoreApp extends StatefulWidget {
  const FireStoreApp({Key? key}) : super(key: key);

  @override
  _FireStoreAppState createState() => _FireStoreAppState();
}

class _FireStoreAppState extends State<FireStoreApp> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference groceries =
        FirebaseFirestore.instance.collection('groceries');

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Grocery List"),
        ),
        body: Center(
          child: StreamBuilder(
              stream: groceries.orderBy('name').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading'));
                }
                return Column(
                  children: [
                    SizedBox(
                      child: TextField(
                        controller: textController,
                      ),
                    ),
                    ListView(
                      children: snapshot.data!.docs.map((grocery) {
                        return Center(
                          child: ListTile(
                            title: Text(grocery['name']),
                            onLongPress: () {
                              grocery.reference.delete();
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            groceries.add({
              'name': textController.text,
            });
            textController.clear();
          },
        ),
      ),
    );
  }
}
