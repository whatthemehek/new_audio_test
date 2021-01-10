part of 'main.dart';

//class BoxDrawer extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    return Drawer(
//      child: ListView(
//        padding: EdgeInsets.zero,
//        children: <Widget>[
//          DrawerHeader(
//            child: Text('Menu'),
//            decoration: BoxDecoration(
//              color: Colors.white,
//            ),
//          ),
//          ListTile(
//            title: Text('Measure Box'),
//            onTap: () {
//              Navigator.pushNamed(context, '/measure');
//            },
//          ),
//          ListTile(
//            title: Text('Beat Box'),
//            onTap: () {
//              Navigator.pushNamed(context, '/beat');
//            },
//          ),
//          ListTile(
//            title: Text('3/4 Box'),
//            onTap: () {
//              Navigator.pushNamed(context, '/threeFour');
//            },
//          ),
//          ListTile(
//            title: Text('Privacy Policy'),
//            onTap: () {
//              Navigator.pushNamed(context, '/privacy');
//            },
//          ),
//          SwitchListTile(
//            title: Text('Screen-reader Optimized'),
//            value: isAccessible,
//            onChanged: (bool value) {
//              setState(() {
//                isAccessible = value;
//              });
//            },
//          ),
//        ],
//      ),
//    );
//  }
//}