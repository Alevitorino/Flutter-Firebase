import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/pages/home/home_page.dart';
import 'package:autonomo_app/pages/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TabNavBar extends StatefulWidget {
  @override
  _TabNavBarState createState() => _TabNavBarState();
}

class _TabNavBarState extends State<TabNavBar>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  Temas temas;
  @override
  void initState() {
    super.initState();
    trocaCor();
    tabController =
        TabController(initialIndex: 0, length: _tabList.length, vsync: this);
  }

  void trocaCor() {
  
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff080626),
      systemNavigationBarDividerColor: null,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,

    ));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  List<Widget> _tabList = [
    HomePage(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _tabList.length,
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: _tabList,
        ),
      ),
      bottomNavigationBar: Container(
        height: 55,
        child: Material(
          color: Theme.of(context).buttonColor,
          child: TabBar(
            indicatorWeight: 2,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xff080626),
            controller: tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: 'Home',
                icon: Icon(
                  Icons.home,
                ),
                iconMargin: null,
              ),
              Tab(
                text: 'Buscar',
                icon: Icon(Icons.search),
                iconMargin: null,
              ),
              Tab(
                text: 'Perfil',
                icon: Icon(
                  Icons.person,
                ),
                iconMargin: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
