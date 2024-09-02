import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_app/firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.useFirestoreEmulator('localhost', 8080);
  firestore.clearPersistence();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Creates a document with test user data.
  Future<void> createDoc() async {
    print("createDoc");
    // 3 random UIDs.
    List<String> userIDs = [
      'mhfmanbVh86izrhRjD7FP9IxPfen',
      "pW0A3ejR7W1eASIkxgwivVpvsy7z",
      "wu72560VaihY2MBTRQSn"
    ];
    final _random = new Random();
    String userID = userIDs[_random.nextInt(userIDs.length)];
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference userDB = db.collection('Users');
    await userDB.doc(userID).set({
      'uid': userID,
      'email': 'fake-user-email@fake.com',
      'preferredCategories': [
        'category_001',
        'category_002',
      ],
      'createdAt': 0,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: Text("Click Me"),
              onPressed: () => createDoc(),
            ),
          ],
        ),
      ),
    );
  }
}
