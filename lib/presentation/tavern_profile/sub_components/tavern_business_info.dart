import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class TavernBusinessInfo extends StatelessWidget {
  const TavernBusinessInfo({
    Key? key,
    required this.businessNumber,
    required this.businessAddress,
    required this.businessHours,
  }) : super(key: key);
  final String businessNumber;
  final String businessAddress;
  final String businessHours;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        profileInfoItem(
            name: 'Business Number',
            value: businessNumber!,
            icon: Icons.description_outlined),
        Divider(
          color: appTheme.gray90060.withOpacity(0.1),
          thickness: 1,
        ),
        profileInfoItem(
            name: 'Business Address',
            value: businessAddress!,
            icon: Icons.location_on_outlined),
        Divider(
          color: appTheme.gray90060.withOpacity(0.1),
          thickness: 1,
        ),
        profileInfoItem(
            name: 'Business Hours',
            value: businessHours!,
            icon: Icons.timelapse_outlined),
      ],
    );
  }
}

class profileInfoItem extends StatelessWidget {
  const profileInfoItem({
    Key? key,
    required this.name,
    required this.value,
    required this.icon,
  }) : super(key: key);
  final String name;
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: appTheme.blueGray800,
            size: 14,
          ),
          SizedBox(width: 6.h),
          Text(name, style: CustomTextStyles.titleSmall12),
          Spacer(),
          Container(
              width: MediaQuery.sizeOf(context).width * .3,
              child: Text(value, style: CustomTextStyles.titleSmall12400)),
        ],
      ),
    );
  }
}
