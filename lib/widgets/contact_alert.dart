import 'package:flutter/material.dart';
import 'package:new_tasabeeh_app/constants/constants.dart';
import 'package:new_tasabeeh_app/constants/space_functions.dart';




class ContactAlert extends StatelessWidget {

  final double size;
  final double padding;
  final String selectedLanguage;

  ContactAlert({this.size, this.padding, this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: TextStyle(fontFamily: 'El Messiri'),
      contentTextStyle: TextStyle(fontFamily: 'El Messiri'),
      backgroundColor: prColor,
      contentPadding: EdgeInsets.all(padding),
      titlePadding: EdgeInsets.all(padding),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (selectedLanguage == languages[0]) IconButton(
            icon: Icon(Icons.cancel),
            color: rdColor,
            iconSize: size * 2,
            onPressed: () => Navigator.of(context).pop(),
          ),
          Text(
            selectedLanguage == languages[0] ? 'اتصل بنا' : 'Contact Us',
            style: TextStyle(
              color: scColor,
              fontSize: size * 1.3,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (selectedLanguage == languages[1]) IconButton(
            icon: Icon(Icons.cancel),
            color: rdColor,
            iconSize: size * 2,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: Container(
        width: size * 30,
        height: size * 12,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.email, color: scColor,),
                title: Text(
                  'hamzaiqa9@gmail.com',
                  style: TextStyle(
                    color: scColor,
                    fontSize: size * 0.6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Container(
                  width: size * 2.5,
                  height: size,
                  decoration: BoxDecoration(
                    color: scColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      selectedLanguage == languages[0] ? 'شخصي' : 'Personal',
                      style: TextStyle(
                        color: prColor,
                        fontSize: size * 0.4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              addVerticalSpace(padding),
              ListTile(
                leading: Icon(Icons.email, color: scColor,),
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'hiqadev@gmail.com',
                    style: TextStyle(
                      color: scColor,
                      fontSize: size * 0.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                trailing: Container(
                  width: size * 2.5,
                  height: size,
                  decoration: BoxDecoration(
                    color: scColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      selectedLanguage == languages[0] ? 'العمل' : 'Work',
                      style: TextStyle(
                        color: prColor,
                        fontSize: size * 0.4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              addVerticalSpace(padding),
              ListTile(
                leading: Icon(Icons.phone, color: scColor,),
                title: Text(
                  '+962 772127805',
                  style: TextStyle(
                      color: scColor,
                      fontSize: size * 0.6,
                      fontWeight: FontWeight.bold
                  ),
                ),
                trailing: Container(
                  width: size * 2.5,
                  height: size,
                  decoration: BoxDecoration(
                    color: scColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      selectedLanguage == languages[0] ? 'شخصي' : 'Personal',
                      style: TextStyle(
                        color: prColor,
                        fontSize: size * 0.4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
