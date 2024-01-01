import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String btnText;
  final IconData? icon;
  final Color? backgroudColor;
  final Color? foregroudColor;
  final double? size;

  const MyButton({
    Key? key,
    required this.btnText,
    required this.onTap,
    this.icon,
    this.backgroudColor,
    this.foregroudColor,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: (backgroudColor == null) ? Colors.black : backgroudColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: (icon == null)
              ? Center(
                  child: Text(
                    btnText,
                    style: TextStyle(
                      color: (foregroudColor == null)
                          ? Colors.white
                          : foregroudColor,
                      fontWeight: FontWeight.bold,
                      fontSize: (size == null) ? 16 : size,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      btnText,
                      style: TextStyle(
                        color: (foregroudColor == null)
                            ? Colors.white
                            : foregroudColor,
                        fontWeight: FontWeight.bold,
                        fontSize: (size == null) ? 16 : size,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(icon, color: foregroudColor, size: 20),
                  ],
                ),
        ),
      ),
    );
  }
}
