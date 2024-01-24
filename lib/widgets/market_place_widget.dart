import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:url_launcher/url_launcher.dart';

class MarketPlaceWidget extends StatelessWidget {
  const MarketPlaceWidget({
    Key? key,
    required this.link,
    required this.showEndIcon,
  }) : super(key: key);
  final String? link;
  final bool showEndIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: showEndIcon
          ? EdgeInsets.symmetric(horizontal: 16, vertical: 16)
          : null,
      padding: showEndIcon
          ? EdgeInsets.symmetric(horizontal: 16, vertical: 10)
          : null,
      decoration: showEndIcon
          ? AppDecoration.fillOnErrorContainer.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder16,
            )
          : null,
      child: GestureDetector(
        onTap: () {
          launchUrl(Uri.parse(link!));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Marketplace :   ',
              style: CustomTextStyles.titleMediumPrimary,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.45,
                child: Text(
                  (link == '' || link == null)
                      ? "No market place linked"
                      : link!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.titleSmall12Blue,
                ),
              ),
            ),
            if (showEndIcon) Spacer(),
            if (showEndIcon)
              Icon(
                Icons.link,
                color: appTheme.blueGray800,
              )
          ],
        ),
      ),
    );
  }
}
