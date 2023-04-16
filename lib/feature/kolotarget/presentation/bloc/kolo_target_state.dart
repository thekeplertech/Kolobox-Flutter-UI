import '../../../dashboard/data/models/investment_goal_response_model.dart';

abstract class KoloTargetState {}

class InitialState extends KoloTargetState {}

class GetGoalState extends KoloTargetState {
  final InvestmentGoalResponseModel model;

  GetGoalState({required this.model});
}
