import 'package:flutter_bloc/flutter_bloc.dart';
import 'quality_of_life_initial_params.dart';
import 'quality_of_life_state.dart';

class QualityOfLifeCubit extends Cubit<QualityOfLifeState> {
  final QualityOfLifeInitialParams initialParams;

  QualityOfLifeCubit(this.initialParams) : super(QualityOfLifeState.initial(initialParams: initialParams));
}