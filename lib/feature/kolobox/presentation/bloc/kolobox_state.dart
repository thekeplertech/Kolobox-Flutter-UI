import '../../../../core/enums/kolobox_fund_enum.dart';
import '../../../dashboard/data/models/earnings_data_model.dart';

abstract class KoloboxState {}

class InitialState extends KoloboxState {}

class ClickOnKoloboxState extends KoloboxState {}

class CallEarningsState extends KoloboxState {
  final KoloboxFundEnum fundEnum;
  final EarningsDataModel earningsDataModel;

  CallEarningsState({required this.fundEnum, required this.earningsDataModel});
}
