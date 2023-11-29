import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
class ListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final int icon;
  ListItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).dividerColor, width: 0.4),
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).indicatorColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(100)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(allIcons[icon]),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  child: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: Theme.of(context).indicatorColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final List<IconData> allIcons = [
    Icons.card_giftcard,
    Icons.card_membership,
    Icons.credit_card,
    Icons.credit_score,
    Icons.diamond,
    Icons.umbrella_sharp,
    Icons.favorite,
    Icons.headphones,
    Icons.home,
    Icons.car_repair,
    Icons.settings,
    Icons.flight,
    Icons.ac_unit,
    Icons.run_circle,
    Icons.book,
    Icons.sports_rugby_rounded,
    Icons.alarm,
    Icons.call,
    Icons.snowing,
    Icons.hearing,
    Icons.music_note,
    Icons.note,
    Icons.edit,
    Icons.sunny,
    Icons.radar,
    BoxIcons.bx_car
  ];
}
