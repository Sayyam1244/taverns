import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import '../../../domain/model/review_model.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    Key? key,
    required this.review,
  }) : super(key: key);
  final ReviewModel review;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 10.v,
      ),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        border: Border.all(
          color: appTheme.gray50,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                review.name!,
                style: CustomTextStyles.titleMediumCircularStdBluegray800,
              ),
              Spacer(),
              Icon(
                Icons.star_rounded,
                color: Colors.orange,
              ),
              Text(
                review.stars.toString() + '.0',
                style: CustomTextStyles.titleMediumCircularStdBluegray90001,
              ),
            ],
          ),
          SizedBox(height: 4.v),
          Text(
            review.createdDate!.format(),
            style: CustomTextStyles.bodySmallCircularStdBluegray40001,
          ),
          SizedBox(height: 6.v),
          Text(
            review.review.toString(),
            style: CustomTextStyles.bodySmallCircularStdBluegray40001
                .copyWith(height: 1.5),
          )
        ],
      ),
    );
  }
}
