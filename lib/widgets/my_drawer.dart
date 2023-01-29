import 'package:flutter/material.dart';

import '../global/global.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //header drawer
          Container(
            color: Colors.black12,
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(

                      child: CircleAvatar(
                        radius: 52,
                       // backgroundImage: NetworkImage(sharedPreferences!.getString("photoUrl")!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  //'name',
                 sharedPreferences!.getString("name")!,
                  style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: "Train"),
                ),
                Text(
                  'email',
                  //sharedPreferences!.getString("email")!,
                  style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: "Train"),
                ),
              ],
            ),
          ),



          //body drawer
          Container(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              
              runSpacing: 16,

             children: [



                   ListTile(
                     leading: const Icon(Icons.home, color: Colors.black,),
                     title: const Text(
                       "Home",
                       style: TextStyle(color: Colors.black),
                     ),
                     onTap: ()
                     {

                     },
                   ),

                   ListTile(
                     leading: const Icon(Icons.monetization_on, color: Colors.black,),
                     title: const Text(
                       "My Earnings",
                       style: TextStyle(color: Colors.black),
                     ),
                     onTap: ()
                     {

                     },
                   ),

                   ListTile(
                     leading: const Icon(Icons.local_shipping, color: Colors.black,),
                     title: const Text(
                       "History - Orders",
                       style: TextStyle(color: Colors.black),
                     ),
                     onTap: ()
                     {

                     },
                   ),

                   ListTile(
                     leading: const Icon(Icons.reorder, color: Colors.black,),
                     title: const Text(
                       "New Orders",
                       style: TextStyle(color: Colors.black),
                     ),
                     onTap: ()
                     {

                     },
                   ),

                   const Divider(
                     height: 0,
                     color: Colors.grey,

                   ),
                   ListTile(
                     leading: const Icon(Icons.exit_to_app, color: Colors.black,),
                     title: const Text(
                       "Sign Out",
                       style: TextStyle(color: Colors.black),
                     ),
                     onTap: ()
                     {

                     },
                   ),

                 ],


            ),
          ),
        ],
      ),
    );
  }
}
