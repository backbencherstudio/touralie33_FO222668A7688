import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/presentation/favourite_screen/view/screen/favourite_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/view/screen/home_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/playlist/view/screen/playlist_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/view/screen/profile_screen.dart';

final parentScreenIndexProvider = StateProvider<int>((ref) => 0);

class ParentScreen extends ConsumerWidget {
  const ParentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectIndex = ref.watch(parentScreenIndexProvider);
    final List<Widget> screens = [
      const HomeScreen(),
      const PlaylistScreen(),
      const FavouriteScreen(),
      const ProfileScreen(),
    ];
    const items = <({IconData icon, String label})>[
      (icon: Icons.home_rounded, label: 'Home'),
      (icon: Icons.grid_view_rounded, label: 'Playlist'),
      (icon: Icons.favorite, label: 'Favorite'),
      (icon: Icons.person, label: 'Profile'),
    ];

    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: screens[selectIndex],
      bottomNavigationBar: SafeArea(
        minimum:  EdgeInsets.fromLTRB(40, 20, 40, 40),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFFDCE8C9)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = selectIndex == index;

              return InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  ref.read(parentScreenIndexProvider.notifier).state = index;
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  padding: EdgeInsets.symmetric(
                    horizontal: isSelected ? 16 : 13,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorManager.backgroundColorgreen
                        : ColorManager.backgroundColorgreen.withValues(alpha: .3),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        size: 18,
                        color: isSelected?  Color(0xFF1E2D11) : const Color.fromARGB(255, 105, 165, 35),
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 6),
                        Text(
                          item.label,
                          style: const TextStyle(
                            color:  Color(0xFF1E2D11),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
