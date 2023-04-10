import '../../../../core/enums/kolobox_fund_enum.dart';

abstract class KoloboxState {}

class InitialState extends KoloboxState {}

class ClickOnKoloboxState extends KoloboxState {}

class CallEarningsState extends KoloboxState {
  final KoloboxFundEnum fundEnum;

  CallEarningsState({required this.fundEnum});
}
