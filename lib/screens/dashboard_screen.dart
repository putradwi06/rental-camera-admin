import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_camera_admin/screens/data_master_screen.dart';
import 'package:rental_camera_admin/styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../menu_app_controller.dart';
import '../responsive.dart';
import 'add_post_camera_screen.dart';
import 'approval_rental_cameras_screen.dart';
import 'list_camera_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with ChangeNotifier {
  int _currentPage = 0;
  final List<Widget> _pages = [
    const DataMasterScreen(),
    const ListCameraScreen(),
    const ApprovalRentalCamerasScreen(),
    const AddPostCameraScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(
        onTap: (int index) {
          setState(() => _currentPage = index);
          context.read<MenuAppController>().closeMenu();
        },
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: SideMenu(
                  onTap: (int index) => setState(() => _currentPage = index),
                ),
              ),
            if (!Responsive.isDesktop(context))
              SizedBox(
                width: 10.w,
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: context.read<MenuAppController>().controlMenu,
                ),
              ),
            Expanded(
              flex: 5,
              child: _pages[_currentPage],
            ),
          ],
        ),
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  final Function(int index) onTap;

  const SideMenu({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerListTile(
            title: "Dashboard",
            icon: Icons.home_rounded,
            press: () => onTap(0),
          ),
          DrawerListTile(
            title: "List Rental",
            icon: Icons.list,
            press: () => onTap(1),
          ),
          DrawerListTile(
            title: "Approval",
            icon: Icons.approval_outlined,
            press: () => onTap(2),
          ),
          DrawerListTile(
            title: "Add Camera",
            icon: Icons.add_outlined,
            press: () => onTap(3),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: kPrimaryColor,
      ),
      title: Text(
        title,
        style: blackTextStyle.copyWith(
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
