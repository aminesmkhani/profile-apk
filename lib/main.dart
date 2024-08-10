import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = Locale('en');
  @override
  Widget build(BuildContext context) {
    Color surfaceColor = Color(0x0dffffff);
    Color primaryColor = Colors.pink.shade400;
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: _themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
          : MyAppThemeConfig.light().getTheme(_locale.languageCode),
      home: MyHomePage(
        toggleThemeMode: () {
          setState(() {
            if (_themeMode == ThemeMode.dark)
              _themeMode = ThemeMode.light;
            else
              _themeMode = ThemeMode.dark;
          });
        },
        selectedLanguageChanged: (_Language newSelectedLanguageByUser) {
        setState(() {
            _locale = newSelectedLanguageByUser == _Language.en
              ? Locale('en')
              : Locale('fa');
        });
        },
      ),
    );
  }
}

class MyAppThemeConfig {
  static const String faPrimaryFontFamily = 'IranYekan';
  final Color primaryColor = Colors.pink.shade400;
  final Color surfaceColor = Color(0x0dffffff);
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color surfacetColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secondaryTextColor = Colors.white70,
        surfacetColor = Color(0x0dffffff),
        backgroundColor = Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;

  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        secondaryTextColor = Colors.grey.shade900.withOpacity(0.8),
        surfacetColor = Color(0x0d000000),
        backgroundColor = Colors.white,
        appBarColor = Color.fromARGB(255, 235, 235, 235),
        brightness = Brightness.light;

  ThemeData getTheme(String languageCode) {
    return ThemeData(
      primarySwatch: Colors.pink,
      primaryColor: primaryColor,
      brightness: brightness,
      dividerColor: surfaceColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
          backgroundColor: appBarColor,
          titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: surfaceColor,
      ),
      useMaterial3: true,
      textTheme: languageCode == 'en' ? enPrimaryTextTheme : faPrimaryTextTheme,
    );
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(TextTheme(
        bodyMedium: TextStyle(fontSize: 15, color: primaryTextColor),
        bodyLarge: TextStyle(fontSize: 13, color: primaryTextColor),
      ));

  TextTheme get faPrimaryTextTheme => TextTheme(
       bodyMedium: TextStyle(
            fontSize: 15,
            color: primaryTextColor,
            fontFamily: faPrimaryFontFamily),
        bodyLarge: TextStyle(
            fontSize: 13,
            color: primaryTextColor,
            fontFamily: faPrimaryFontFamily),
      );
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(_Language _language) selectedLanguageChanged;
  const MyHomePage(
      {super.key,
      required this.toggleThemeMode,
      required this.selectedLanguageChanged});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _SkillType _skill = _SkillType.photoshop;
  _Language _language = _Language.en;
  void _updateSelectedSkill(_SkillType skillType) {
    setState(() {
      this._skill = skillType;
    });
  }

  void _updateSelectedLanguage(_Language language) {
    widget.selectedLanguageChanged(language);
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.profileTitle),
          actions: [
            Icon(CupertinoIcons.chat_bubble_text),
            InkWell(
              onTap: widget.toggleThemeMode,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
                child: Icon(CupertinoIcons.sun_max_fill),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/profile_image.png',
                          width: 60,
                          height: 60,
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localization.name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(localization.job),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.location_solid,
                                  size: 13,
                                  color: Color.fromARGB(200, 255, 255, 255),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  localization.location,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color:
                                          Color.fromARGB(200, 255, 255, 255)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.heart,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                child: Text(
                  localization.summery,
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.selectedLanguage),
                    CupertinoSlidingSegmentedControl<_Language>(
                        groupValue: _language,
                        thumbColor: Colors.pink,
                        children: {
                          _Language.en: Text(localization.enLanguage),
                          _Language.fa: Text(localization.faLanguage)
                        },
                        onValueChanged: (value) {
                          if (value != null) _updateSelectedLanguage(value);
                        })
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      localization.skills,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(CupertinoIcons.chevron_down, size: 12),
                  ],
                ),
              ),
              Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Skill(
                      type: _SkillType.photoshop,
                      title: "Photoshop",
                      imagePath: 'assets/images/app_icon_01.png',
                      shadowColor: Colors.blue,
                      isActive: _skill == _SkillType.photoshop,
                      onTap: () {
                        _updateSelectedSkill(_SkillType.photoshop);
                      },
                    ),
                    Skill(
                      type: _SkillType.xd,
                      title: "Adobe XD",
                      imagePath: 'assets/images/app_icon_05.png',
                      shadowColor: Colors.pink,
                      isActive: _skill == _SkillType.xd,
                      onTap: () {
                        _updateSelectedSkill(_SkillType.xd);
                      },
                    ),
                    Skill(
                      type: _SkillType.illustrator,
                      title: "Iilestretor",
                      imagePath: 'assets/images/app_icon_04.png',
                      shadowColor: Colors.orange,
                      isActive: _skill == _SkillType.illustrator,
                      onTap: () {
                        _updateSelectedSkill(_SkillType.illustrator);
                      },
                    ),
                    Skill(
                      type: _SkillType.afterEffect,
                      title: "After Effect",
                      imagePath: 'assets/images/app_icon_03.png',
                      shadowColor: Colors.blue.shade600,
                      isActive: _skill == _SkillType.afterEffect,
                      onTap: () {
                        _updateSelectedSkill(_SkillType.afterEffect);
                      },
                    ),
                    Skill(
                      type: _SkillType.lightRoom,
                      title: "Lightroom",
                      imagePath: 'assets/images/app_icon_02.png',
                      shadowColor: Colors.blue,
                      isActive: _skill == _SkillType.lightRoom,
                      onTap: () {
                        _updateSelectedSkill(_SkillType.lightRoom);
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.personalInformation,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: localization.email,
                        prefixIcon: Icon(CupertinoIcons.at),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: localization.password,
                        prefixIcon: Icon(CupertinoIcons.lock),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(localization.save),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class Skill extends StatelessWidget {
  final _SkillType type;
  final String title;
  final String imagePath;
  final Color shadowColor;
  final bool isActive;
  final Function() onTap;

  const Skill(
      {super.key,
      required this.type,
      required this.title,
      required this.imagePath,
      required this.shadowColor,
      required this.isActive,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final BorderRadius defaultBoarderRadius = BorderRadius.circular(12);
    return InkWell(
      onTap: onTap,
      borderRadius: defaultBoarderRadius,
      child: Container(
        width: 110,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: defaultBoarderRadius,
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor.withOpacity(0.5), blurRadius: 20)
                      ],
                    )
                  : null,
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

enum _SkillType {
  photoshop,
  xd,
  illustrator,
  afterEffect,
  lightRoom,
}

enum _Language {
  en,
  fa,
}
