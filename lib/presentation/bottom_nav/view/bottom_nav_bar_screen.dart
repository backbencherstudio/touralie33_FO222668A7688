import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../../core/resource/constants/color_manger.dart';
import '../viewmodel/bottom_nav_bar_viewmodel.dart';

class BottomNavBarScreen extends ConsumerStatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  ConsumerState<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends ConsumerState<BottomNavBarScreen> {
  DateTime? _lastPressedAt;

  final List<Widget> _screenList = [
    const Scaffold(body: Center(child: Text("Home"))),
    const Scaffold(body: Center(child: Text("dangerous"))),
    const Scaffold(body: Center(child: Text("search"))),
    const Scaffold(body: Center(child: Text("settings"))),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        final now = DateTime.now();
        if (_lastPressedAt == null ||
            now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          _lastPressedAt = now;
          Fluttertoast.showToast(msg: "Press back again to exit");
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: _screenList[ref.watch(bottomNavBarProvider)],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorManager.background,
          onTap: ref.read(bottomNavBarProvider.notifier).onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.dangerous), label: "dangerous"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings"),
          ],
        ),
      ),
    );
  }
}

