import 'package:flutter/material.dart';
import 'package:new_tasabeeh_app/constants/constants.dart';
import 'package:new_tasabeeh_app/constants/space_functions.dart';



class HelpScreen extends StatelessWidget {

  final String _selectedLanguage;
  HelpScreen(this._selectedLanguage);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = (mediaQuery.orientation == Orientation.landscape);
    final Size screenSize = MediaQuery.of(context).size;
    final size = isLandscape ? screenSize.height * 0.05 : screenSize.width * 0.05;
    final double padding = isLandscape ? screenSize.height * 0.04 : screenSize.width * 0.04;

    return SafeArea(
        child: Scaffold(
          backgroundColor: prColor,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(padding),
                child: Row(
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
                          icon: Icon(Icons.arrow_back),
                          color: prColor,
                          iconSize: size,
                          alignment: Alignment.center,
                          onPressed: () {
                           Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        _selectedLanguage == languages[0] ? 'ساعدني' : 'Help Me',
                        style: TextStyle(
                          fontSize: size * 1.5,
                          fontWeight: FontWeight.bold,
                          color: scColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(top: padding, bottom: padding * 2, left: padding, right: padding),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BuildQuestion(
                              question: _selectedLanguage == languages[0]
                                  ?
                              'كيف يمكنني استخدام هذا التطبيق؟'
                                  :
                              'How to use this application?',
                              answer: _selectedLanguage == languages[0]
                                  ?
                              'استخدام هذا التطبيق سهل جدا, قم بالنقر على أي مكان في الشاشة لكي يبدأ عداد التسبيح بالعمل'
                                  :
                              'This application is too easy, just click on any place on your screen and start the tasbeeh counter',
                              padding: padding,
                              selectedLanguage: _selectedLanguage,
                            ),
                            BuildQuestion(
                              question: _selectedLanguage == languages[0]
                                  ?
                              'كيف يمكنني اعادة عداد التسبيح الى الصفر؟'
                                  :
                              'How to reset the tasbeeh counter to zero ?',
                              answer: _selectedLanguage == languages[0]
                                  ?
                              'قم بالضغط على زر التصفير'
                                  :
                              'Just click on the Reset button',
                              padding: padding,
                              selectedLanguage: _selectedLanguage,
                            ),
                            BuildQuestion(
                              question: _selectedLanguage == languages[0]
                                  ?
                              'كيف اتواصل مع مركز المساعدة؟'
                                  :
                              'How to contact help center?',
                              answer: _selectedLanguage == languages[0]
                                  ?
                              'يمكنك التواصل مع مركز المساعدة عبر هذا الايميل (hiqadev@gmail.com)'
                                  :
                              'You can contact with them by this email: (hiqadev@gmail.com)',
                              padding: padding,
                              selectedLanguage: _selectedLanguage,
                            ),
                            BuildQuestion(
                              question: _selectedLanguage == languages[0]
                                  ?
                              'من يمتلك هذا التطبيق؟'
                                  :
                              'Who own this application?',
                              answer: _selectedLanguage == languages[0]
                                  ?
                              'هذا التطبيق هو ملك لكل مسلم'
                                  :
                              'This application is owned by every muslims',
                              padding: padding,
                              selectedLanguage: _selectedLanguage,
                            ),
                            BuildQuestion(
                              question: _selectedLanguage == languages[0]
                                  ?
                              'كيف يمكنني دعمك؟'
                                  :
                              'How can i donate you?',
                              answer: _selectedLanguage == languages[0]
                                  ?
                              'يمكنك أن تدعو لي وأن تنشر هذا التطبيق بين أصدقائك لتكون شريكا لي في الأجر, وشكرا جزيلا لك'
                                  :
                              'You can pray to God for me and share the application with your friends, and thank you very much',
                              padding: padding,
                              selectedLanguage: _selectedLanguage,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: isLandscape ? screenSize.width * 0.09 : _selectedLanguage == languages[0] ? screenSize.height * 0.09 : screenSize.height * 0.09,
                color: scColor,
                alignment: Alignment.center,
                padding: EdgeInsets.all(padding),
                child: Text(
                  _selectedLanguage == languages[0]
                      ?
                  'اذا كنت تواجه مشكلة تواصل معي عبر الايميل (hiqadiv@gmail.com)'
                      :
                  'Please if you have any problems contact me at (hiqadev@gmail.com)',
                  textAlign: _selectedLanguage == languages[0] ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    fontSize: size * 0.5,
                    color: prColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}


class BuildQuestion extends StatelessWidget {
  final String question;
  final String answer;
  final double padding;
  final TextStyle textStyle;
  final String selectedLanguage;

  BuildQuestion({
    this.question,
    this.answer,
    this.padding,
    this.textStyle = const TextStyle(color: Color(0xffB8D9C6),),
    this.selectedLanguage,
});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: selectedLanguage == languages[0] ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(selectedLanguage == languages[0] ? 'سؤال: $question' : 'Question: $question', textAlign: selectedLanguage == languages[0] ? TextAlign.right : TextAlign.left, style: textStyle,),
        addVerticalSpace(padding * 1.5),
        Text(selectedLanguage == languages[0] ? 'اجابة: $answer' : 'Answer: $answer', textAlign: selectedLanguage == languages[0] ? TextAlign.right : TextAlign.left, style: textStyle,),
        addVerticalSpace(padding),
        Divider(color: scColor,),
        addVerticalSpace(padding * 1.5),
      ],
    );
  }
}
