import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

Image logoImage(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 219,
    height: 182,
  );
}

TextField reuseableTextField(String text, IconData icon, bool isPasswordType, bool isEnabled,
    TextEditingController controller) {
  // bool _obsecureText = isPasswordType;
  return TextField(
    controller: controller,
    // obscureText: _obsecureText,
    obscureText: isPasswordType,
    enabled: isEnabled,
    enableSuggestions: isPasswordType,
    autocorrect: isPasswordType,
    cursorColor: Colors.grey,
    style: TextStyle(color: Colors.black54.withOpacity(0.8)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.black26,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Constants.anaRenk.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container signInSignOutButton(BuildContext context, bool isLogin,
    Function onTap) {
  return Container(
    width: MediaQuery
        .of(context)
        .size
        .width,
    height: 55,
    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'LOG IN' : 'SIGN UP',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white70;
            }
            return Constants.anaRenk;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
    ),
  );
}

Container button(BuildContext context, Function onTab, Widget icon) {

  return Container(
    width: MediaQuery
        .of(context)
        .size
        .width,
    height: 55,

    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
    child: ElevatedButton(
    onPressed: () { onTab();},
    child: icon,
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.white70;
          }
          return Colors.black;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
  ),
  );
}