import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon icon;
  const ListItem({
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
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColorDark,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(100)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: icon,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.505,
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
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
