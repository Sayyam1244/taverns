import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.colorScheme.background,
      child: Center(
        child: Container(
          height: 40.v,
          width: 40.v,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
