import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:selfstorage/pages/contactPage.dart';
import 'package:selfstorage/pages/discountPage.dart';
import 'package:selfstorage/pages/homePage.dart';
import 'package:selfstorage/pages/sitePage.dart';
import 'package:selfstorage/pages/subscriptionPage.dart';
import 'package:selfstorage/widgets/accountAvatar.dart';

class rootPage extends StatefulWidget {
  static const routeName = '/rootPage';

  const rootPage({super.key});

  @override
  State<rootPage> createState() => _rootPageState();
}

class _rootPageState extends State<rootPage> {
  late PageController _pageController;
  late SideMenuController _sideMenuController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _sideMenuController = SideMenuController();

    _sideMenuController.addListener((index) {
      _pageController.jumpToPage(index);
    });
  }

  List<SideMenuItem> _buildMenuItems() {
    return [
      SideMenuItem(
        title: 'Home page',
        onTap: (index, _) {
          _sideMenuController.changePage(index);
        },
        icon: Icon(Icons.home),
      ),
      SideMenuItem(
        title: 'Subscription',
        onTap: (index, _) {
          _sideMenuController.changePage(index);
        },
        icon: Icon(Icons.loop),
      ),
      SideMenuItem(
        title: 'Site',
        onTap: (index, _) {
          _sideMenuController.changePage(index);
        },
        icon: Icon(Icons.location_pin),
      ),
      SideMenuItem(
        title: 'Contact',
        onTap: (index, _) {
          _sideMenuController.changePage(index);
        },
        icon: Icon(Icons.person),
      ),
      SideMenuItem(
        title: 'Discount',
        onTap: (index, _) {
          _sideMenuController.changePage(index);
        },
        icon: Icon(Icons.shield),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Animate(
              effects: [FadeEffect(duration: Duration(milliseconds: 700))],
              child: customAccountWidget())
        ],
        leading: Animate(
          effects: [FadeEffect(duration: Duration(milliseconds: 700))],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png'),
          ),
        ),
        leadingWidth: 200,
      ),
      backgroundColor: Color.fromRGBO(242, 247, 252, 1),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Animate(
            effects: [FadeEffect(duration: Duration(milliseconds: 700))],
            child: SideMenu(
              style: SideMenuStyle(
                selectedTitleTextStyle: TextStyle(color: Colors.orange , fontWeight: FontWeight.w600),
                selectedIconColor: Colors.orange,
                hoverColor: Colors.blue[100],
                unselectedIconColor: Color.fromRGBO(20, 53, 96, 1),
                openSideMenuWidth: 200
                //hoverColor: Colors.orange,
               //   selectedColor: Colors.orange  ,
                  ),
              controller: _sideMenuController,
              // title: Image.asset('assets/logo.png'),
              items: _buildMenuItems(),
            ),
          ),
          Expanded(
              child: PageView(
            controller: _pageController,
            children: [
              sitePage(),
              homePage(),
              subscriptionPage(),
              contactPage(),
              discountPage(),

            ],
          ))
        ],
      ),
    );
  }
}
