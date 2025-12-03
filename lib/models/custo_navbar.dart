import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final List<IconData> icons;
  final bool showCenterButton;
  final VoidCallback? onCenterButtonTap;

  const CustomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.icons,
    this.showCenterButton = false,
    this.onCenterButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background navbar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          margin: const EdgeInsets.only(top: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                spreadRadius: -5,
                offset: const Offset(0, 5),
                color: Colors.black.withOpacity(0.15),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(icons.length, (index) {
              final isActive = selectedIndex == index;

              return GestureDetector(
                onTap: () => onTap(index),
                child: Icon(
                  icons[index],
                  size: 28,
                  color: isActive ? const Color(0xFF066A7F) : Colors.grey[400],
                ),
              );
            }),
          ),
        ),

        // Center button (opsional)
        if (showCenterButton)
          Positioned(
            top: -5,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: onCenterButtonTap,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF066A7F),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
