import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FireStoreApp());
}

class FireStoreApp extends StatefulWidget {
  const FireStoreApp({Key? key}) : super(key: key);

  @override
  _FireStoreAppState createState() => _FireStoreAppState();
}

class _FireStoreAppState extends State<FireStoreApp> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext ctx) {
    CollectionReference groceries =
        FirebaseFirestore.instance.collection('groceries');

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,

        appBar: AppBar(
          title: const Text(
            "Grocery List",
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 23, color: Color.fromARGB(221, 46, 46, 46)),
          ),
        ),
        body: Center(
          child: StreamBuilder(
              stream: groceries.orderBy('name').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: Text('Loading'));
                }
                return ListView(
                  children: snapshot.data!.docs.map((grocery) {
                    return Center(
                      child: ListTile(
                        leading: const Icon(
                          Icons.circle,
                          size: 12,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            grocery.reference.delete();
                          },
                        ),
                        title: Text(grocery['name']),
                        // onLongPress: () {
                        //   grocery.reference.delete();
                        // },
                      ),
                    );
                  }).toList(),
                );
              }),
        ),
        floatingActionButton: SingleChildScrollView(
          child: Builder(
            builder: (context) => FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text(
                      "Add Grocery",
                      textAlign: TextAlign.center,
                    ),
                    content: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: const Color.fromARGB(255, 231, 231, 231),
                      child: Container(
                        padding: const EdgeInsets.only(left: 12),
                        child: TextFormField(
                          controller: textController,
                          decoration: const InputDecoration(
                            hintText: "Add your item here...",
                            border: InputBorder.none,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            groceries.add({
                              'name': textController.text,
                            });
                            textController.clear();
                            Navigator.of(ctx).pop();
                          },
                          child: const Text(
                            "Add Item To List",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.save),
        //   onPressed: () {
        //     groceries.add({
        //       'name': textController.text,
        //     });
        //     textController.clear();
        //   },
        // ),
      ),
    );
  }

  Future<dynamic> showTextField(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      // color is applied to main screen when modal bottom screen is displayed
      barrierColor: Colors.greenAccent,
      //background color for modal bottom screen
      backgroundColor: Colors.yellow,
      //elevates modal bottom screen
      elevation: 10,
      // gives rounded corner to modal bottom screen
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        // UDE : SizedBox instead of Container for whitespaces
        return SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('GeeksforGeeks'),
              ],
            ),
          ),
        );
      },
    );
  }
}
