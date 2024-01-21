import 'package:taverns/domain/model/review_model.dart';

import 'reviews_initial_params.dart';

class ReviewsState {
  final bool isLoading;
  final List<ReviewModel> reviews;
  const ReviewsState({required this.reviews, required this.isLoading});

  factory ReviewsState.initial({required ReviewsInitialParams initialParams}) => ReviewsState(reviews: [], isLoading: true);

  ReviewsState copyWith({List<ReviewModel>? reviews, bool? isLoading}) => ReviewsState(
        reviews: reviews ?? this.reviews,
        isLoading: isLoading ?? this.isLoading,
      );
}
