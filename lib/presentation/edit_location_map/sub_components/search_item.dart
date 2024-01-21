import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({Key? key, required this.searchText, required this.onTap}) : super(key: key);
  final String searchText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: appTheme.white,
          border: Border(
            top: BorderSide(color: appTheme.gray400),
            bottom: BorderSide(color: appTheme.gray400),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.trending_up,
              color: appTheme.gray800,
            ),
            SizedBox(width: 12.h),
            Expanded(
              child: Text(
                searchText,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
