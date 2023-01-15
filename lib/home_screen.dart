import 'package:bim493_finalhw/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home Page'),),
        drawer: MyDrawer(),
        body: Container(child: Text('dfgsdfgsdfgsdfgsdfgsdfgsdfgsdfg'),));
  }
}
