import 'package:autonomo_app/botoes.dart';
import 'package:autonomo_app/components/bottomNavigationBar.dart';
import 'package:autonomo_app/components/tabNavigationBar.dart';
import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/pages/home/home_page.dart';
import 'package:autonomo_app/pages/login/signin/login_page.dart';
import 'package:autonomo_app/pages/login/signup/step01/signup_page.dart';
import 'package:autonomo_app/pages/login/signup/step02/signup_view2.dart';
import 'package:autonomo_app/pages/login/signup/step03/escolheCategoria_view.dart';
import 'package:autonomo_app/pages/profile/profile_view.dart';
import 'package:autonomo_app/pages/splashscreen/splashscreen.dart';
import 'package:autonomo_app/services/auth.dart';
import 'package:autonomo_app/services/database.dart';
import 'package:autonomo_app/whapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseService>(
            create: (context) => DatabaseService())
      ],
      child: MyApp(),
    ),
  );
}

Temas temas;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [const Locale('pt', 'BR')],
        debugShowCheckedModeBanner: false,
        title: 'Autônomo App',

        theme: ThemeData(
          scaffoldBackgroundColor: whiteColor,
          primaryColor: Color(0xff080626), 
          accentColor: Color(0xff080626), 
          buttonColor:Color(0xff080626),
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,

          dividerColor: Colors.grey[300],
          
          textTheme: TextTheme(
            headline1: GoogleFonts.quicksand(
                fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
            headline2: GoogleFonts.quicksand(
                fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
            headline3: GoogleFonts.quicksand(
                fontSize: 48, fontWeight: FontWeight.w400),
            headline4: GoogleFonts.quicksand(
                fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            headline5: GoogleFonts.quicksand(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.grey[850]),
            headline6: GoogleFonts.quicksand(
                fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
            subtitle1: GoogleFonts.quicksand(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
            subtitle2: GoogleFonts.quicksand(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
            bodyText1: GoogleFonts.quicksand(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
            bodyText2: GoogleFonts.quicksand(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
              color: Color(0xFF605e5c),
            ),
            button: GoogleFonts.quicksand(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
            caption: GoogleFonts.quicksand(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
            overline: GoogleFonts.quicksand(
                fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.5),
          ),
         
          inputDecorationTheme: InputDecorationTheme(
         
            floatingLabelBehavior: FloatingLabelBehavior.auto,

            labelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),

            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: cinzaMS,
                width: 4.0,
                style: BorderStyle.solid,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: cinzaMS,
                width: 1.5,
                style: BorderStyle.solid,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2.0,
                style: BorderStyle.solid,
              ),
            ),
      
          ),
        ).copyWith(),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF181818),
          buttonColor: azulMtEscuro,

          primaryColor: Color(0xff080626), 
          accentColor: Color(0xff080626), 
          backgroundColor: Colors.red,
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,

          dividerColor: Colors.grey[800],

          textTheme: TextTheme(
            headline1: GoogleFonts.quicksand(
                fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
            headline2: GoogleFonts.quicksand(
                fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
            headline3: GoogleFonts.quicksand(
                fontSize: 48, fontWeight: FontWeight.w400),
            headline4: GoogleFonts.quicksand(
                fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            headline5: GoogleFonts.quicksand(
                fontSize: 24, fontWeight: FontWeight.w400),
            headline6: GoogleFonts.quicksand(
                fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
            subtitle1: GoogleFonts.quicksand(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
            subtitle2: GoogleFonts.quicksand(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
            bodyText1: GoogleFonts.quicksand(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
            bodyText2: GoogleFonts.quicksand(
                fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            button: GoogleFonts.quicksand(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
            caption: GoogleFonts.quicksand(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
            overline: GoogleFonts.quicksand(
                fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.5),
          ),

          // CampoInput
          inputDecorationTheme: InputDecorationTheme(
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              borderSide: BorderSide(color: Color(0xff080626), width: 3.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              borderSide: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 2.0,
                style: BorderStyle.solid,
              ),
            ),
           
          ),
        ).copyWith(),
        themeMode: ThemeMode.light,
       
        initialRoute: '/whapper',
        routes: <String, WidgetBuilder>{
          '/splash': (BuildContext context) => SplashScreen(),
          '/whapper': (BuildContext context) => Whapper(),
          '/home': (BuildContext context) => HomePage(),
          '/signup': (BuildContext context) => SignupPage(),
          '/signup2': (BuildContext context) => SignupPage2(),
          '/': (BuildContext context) => LoginPage(),
          '/profile': (BuildContext context) => ProfileView(),
          '/tabNavBar': (BuildContext context) => TabNavBar(),
          '/NavBar': (BuildContext context) => BarraDeNavegacao(),
          '/escolheCat': (BuildContext context) => EscolheCategoriaView(),
          '/botoes': (context) => BotoesView(),
        },
      ),
    );
  }
}
