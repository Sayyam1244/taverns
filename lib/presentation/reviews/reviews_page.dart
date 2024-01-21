import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/domain/model/review_model.dart';
import 'package:taverns/presentation/reviews/reviews_state.dart';
import 'package:taverns/presentation/reviews/sub_components/review_item.dart';
import 'package:taverns/widgets/custome_loading_widget.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import 'reviews_cubit.dart';

class ReviewsPage extends StatefulWidget {
  final ReviewsCubit cubit;

  const ReviewsPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsState();
}

class _ReviewsState extends State<ReviewsPage> {
  ReviewsCubit get cubit => widget.cubit;

  @override
  void initState() {
    cubit.getReviews(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray5001,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70.v,
          backgroundColor: theme.colorScheme.background,
          elevation: 0,
          title: AppbarSubtitleOne(text: "Rating & Reviews"),
        ),
        body: BlocBuilder<ReviewsCubit, ReviewsState>(
          bloc: cubit,
          builder: (context, state) => state.isLoading
              ? CustomLoadingWidget()
              : ListView(
                  children:
                      state.reviews.map((e) => ReviewItem(review: e)).toList(),
                ),
        ),
      ),
    );
  }
}
