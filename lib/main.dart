import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_tasabeeh_app/constants/constants.dart';
import 'package:new_tasabeeh_app/constants/space_functions.dart';
import 'package:new_tasabeeh_app/screens/help_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_tasabeeh_app/widgets/contact_alert.dart';
import 'package:new_tasabeeh_app/widgets/custom_button.dart';








void main() => runApp(
  MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        fontFamily: 'El Messiri'
    ),
  ),
);



class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _selectedLanguage = 'AR';
  int _tasbeehCounter;
  bool _isLoading = false;
  String _tasbeehaText = '';
  var _currentBackPressTime;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  _addTasbeeha() async {
    setState(() {
      _tasbeehCounter++;
    });
    _updateTasabeeh();
  }

  _resetTasbeehCounter() {
    setState(() {
      _tasbeehCounter = 0;
    });
    _resetTasabeeh();
  }

  Future<void> _resetTasabeeh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('tasabeeh', 0);
  }

  Future<void> _updateTasabeeh() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('tasabeeh', _tasbeehCounter);
  }

  Future<void> _getTasabeeh() async {
    setState(() {
      _isLoading = true;
    });
    int loadedTasabeeh;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loadedTasabeeh = prefs.getInt('tasabeeh');
    if (loadedTasabeeh != null) {
      _tasbeehCounter = loadedTasabeeh;
    }
    else {
      _tasbeehCounter = 0;
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _setLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', _selectedLanguage);
  }

  Future<void> _getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('lang') == null) {
      _selectedLanguage = languages[0];
    }
    else {
      _selectedLanguage = prefs.getString('lang');
    }
  }





  _showDialog(double size, double padding) {
    showDialog(context: context, builder: (context) => ContactAlert(size: size, padding: padding, selectedLanguage: _selectedLanguage,));
  }

  _submit() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      setState(() {
        _controller.text = _controller.text.trim();
        _tasbeehaText = _controller.text;
      });
      Navigator.of(context).pop();
    }
    else {
      return;
    }
  }



  Future<bool> onWillPop(String selectedLang) {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: selectedLang == languages[0] ? 'اضغط مرة أخرى للخروج' : 'Click again to exit',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 12.0,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }




  _showAddThekerDialog(double size, double padding, bool isLandscape) {
    showDialog(context: context, builder: (context) => AlertDialog(
      titleTextStyle: TextStyle(fontFamily: 'El Messiri'),
      contentTextStyle: TextStyle(fontFamily: 'El Messiri'),
      backgroundColor: prColor,
      contentPadding: EdgeInsets.only(top: isLandscape ? 0 : padding * 2.5, left: padding, right: padding),
      titlePadding: EdgeInsets.only(top: isLandscape ? padding * 0.5 : padding, left: padding, right: padding),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_selectedLanguage == languages[0]) IconButton(
            icon: Icon(Icons.cancel),
            color: rdColor,
            iconSize: isLandscape ? size * 1.5 : size * 2,
            onPressed: () => Navigator.of(context).pop(),
          ),
          Text(
            _selectedLanguage == languages[0] ? 'اضافة ذكر' : 'Add Theker',
            style: TextStyle(
              color: scColor,
              fontSize: isLandscape ? size : size * 1.3,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (_selectedLanguage == languages[1]) IconButton(
            icon: Icon(Icons.cancel),
            color: rdColor,
            iconSize: isLandscape ? size * 1.5 : size * 2,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: Container(
        width: size * 30,
        height: size * 10.5,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Directionality(
                  textDirection: _selectedLanguage == languages[0] ? TextDirection.rtl : TextDirection.ltr,
                  child: TextFormField(
                    controller: _controller,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    textDirection: _selectedLanguage == languages[0] ? TextDirection.rtl : TextDirection.ltr,
                    style: TextStyle(
                      color: scColor,
                      fontSize: size,
                    ),
                    cursorColor: scColor,
                    scrollPhysics: BouncingScrollPhysics(),
                    decoration: InputDecoration(
                      hintTextDirection: _selectedLanguage == languages[0] ? TextDirection.rtl : TextDirection.ltr,
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: size,
                      ),
                      hintText: _selectedLanguage == languages[0] ? 'الله أكبر' : 'Allah Akbar',
                      errorStyle: TextStyle(
                        fontSize: size / 2.3,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return _selectedLanguage == languages[0] ? 'لا يمكن ان يكون الذكر فارغا' : 'Theker can\'t be empty';
                      }
                      if (value.length > 400) {
                        return _selectedLanguage == languages[0] ? 'لا يمكن ان يكون الذكر بهذا الحجم, الرجاء حذف جزء منه' : 'Theker is too long';
                      }
                      else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              addVerticalSpace(isLandscape ? padding * 4 : padding * 5),
              customButton('اضافة', 'Add', _selectedLanguage, size, _submit),
            ],
          ),
        ),
      ),
    ),);
  }

  @override
  void initState() {
    super.initState();
    _getTasabeeh();
    _getLanguage();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = (mediaQuery.orientation == Orientation.landscape);
    final Size screenSize = MediaQuery.of(context).size;
    final size = isLandscape ? screenSize.height * 0.05 : screenSize.width * 0.05;
    final double padding = isLandscape ? screenSize.height * 0.04 : screenSize.width * 0.04;


    return WillPopScope(
      onWillPop: () => onWillPop(_selectedLanguage),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          key: _scaffoldKey,
          backgroundColor: prColor,
          drawer: Drawer(
            child: Container(
              color: scColor,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  UserAccountsDrawerHeader(
                      accountName: Text(''),
                      accountEmail: Text(''),
                      decoration: BoxDecoration(
                          color: prColor,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/tasabeehLogo.PNG'),
                          )
                      )
                  ),
                  ListTile(
                      title: Text(
                        _selectedLanguage == languages[0] ? 'English Language' : 'اللغة العربية',
                        style: TextStyle(
                            color: prColor
                        ),
                      ),
                      trailing: Icon(Icons.settings, color: prColor,),
                      onTap: () {
                        if (_selectedLanguage == languages[0]) {
                          setState(() {
                            _selectedLanguage = languages[1];
                          });
                          _setLanguage();
                          _scaffoldKey.currentState.openEndDrawer();
                        }
                        else {
                          setState(() {
                            _selectedLanguage = languages[0];
                          });
                          _setLanguage();
                          _scaffoldKey.currentState.openEndDrawer();
                        }
                      }
                  ),
                  ListTile(
                      title: Text(
                        _selectedLanguage == languages[0] ? 'تحتاج للمساعدة؟' : 'Need Help?',
                        style: TextStyle(
                            color: prColor
                        ),
                      ),
                      trailing: Icon(Icons.help_outlined, color: prColor,),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HelpScreen(_selectedLanguage)));
                      }
                  ),
                  ListTile(
                    title: Text(
                      _selectedLanguage == languages[0] ? 'اتصل بنا' : 'Contact Us',
                      style: TextStyle(
                          color: prColor
                      ),
                    ),
                    trailing: Icon(Icons.phone_enabled, color: prColor,),
                    onTap: () => _showDialog(size, padding),
                  ),
                  Divider(
                    color: prColor,
                  ),
                  ListTile(
                    title: Text(
                      _selectedLanguage == languages[0] ? 'اغلاق' : 'Close',
                      style: TextStyle(
                          color: prColor
                      ),
                    ),
                    trailing: Icon(Icons.cancel, color: prColor,),
                    onTap: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ),
          ),
          body: InkWell(
            onTap: _addTasbeeha,
            splashColor: rdColor,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size * 2.4,
                        height: size * 2.4,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          color: scColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: Icon(Icons.menu),
                            color: prColor,
                            iconSize: size,
                            alignment: Alignment.center,
                            onPressed: () {
                              _scaffoldKey.currentState.openDrawer();
                            },
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          _selectedLanguage == languages[0] ? 'تسابيح' : 'TASABEEH',
                          style: TextStyle(
                            fontSize: size * 1.5,
                            color: scColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: _isLoading
                        ?
                    CircularProgressIndicator(
                      backgroundColor: scColor,
                      valueColor: AlwaysStoppedAnimation<Color>(prColor),
                    )
                        :
                    Text(
                      '$_tasbeehCounter',
                      style: TextStyle(
                        fontSize: _tasbeehCounter.toString().length > 12 ? size * 1.5 : _tasbeehCounter.toString().length > 9 ? size * 2 : _tasbeehCounter.toString().length > 6 ? size * 2.5 : size * 4,
                        fontWeight: FontWeight.bold,
                        color: scColor,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: padding * 10),
                    child: _isLoading
                        ?
                    CircularProgressIndicator(
                      backgroundColor: scColor,
                      valueColor: AlwaysStoppedAnimation<Color>(prColor),
                    )
                        :
                    Text(
                      _tasbeehaText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: _tasbeehaText.toString().length > 400 ? size * 0.3 : _tasbeehaText.toString().length > 200 ? size * 0.4 : _tasbeehaText.toString().length > 59 ? size * 0.5 : _tasbeehaText.toString().length > 39 ? size * 0.8 : _tasbeehaText.toString().length > 29 ? size : _tasbeehaText.toString().length > 19 ? size * 1.2 : _tasbeehaText.toString().length > 10 ? size * 1.5 : size * 1.8,
                        fontWeight: FontWeight.bold,
                        color: scColor,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: customButton('تصفير', 'Reset', _selectedLanguage, size, _resetTasbeehCounter),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: TextButton(
                      child: Text(
                        _selectedLanguage == languages[0] ? 'اضافة ذكر' : 'Add Theker',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: rdColor,
                          fontSize: size * 0.7,
                        ),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () => _showAddThekerDialog(size, padding, isLandscape),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



