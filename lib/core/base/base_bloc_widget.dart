import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../routes/routes.dart';
import '../bloc/master_bloc.dart';
import '../bloc/master_state.dart';
import '../colors/color_list.dart';
import '../constants/image_constants.dart';
import '../constants/message_constants.dart';
import '../ui/widgets/loading_dialog.dart';
import '../ui/widgets/toast_widget.dart';
import '../utils/utils.dart';
import 'base_screen.dart';

abstract class BaseBlocWidget extends BaseScreen {
  const BaseBlocWidget({Key? key}) : super(key: key);
}

abstract class BaseBlocWidgetState<T extends BaseBlocWidget>
    extends BaseScreenState<T> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  bool isDialogShowing = false;

  @override
  Widget body(BuildContext context) => MultiBlocListener(
        listeners: [
          BlocListener<MasterBloc, BaseApiState>(
            listenWhen: (prevState, curState) {
              return prevState != curState;
            },
            listener: (context, state) {
              if (state is ApiErrorState && isDialogShowing) {
                hideDialog();
                Utils.showToast(
                    context,
                    ToastWidget(
                      state.message ?? '',
                      borderColor: ColorList.redDarkColor,
                      backgroundColor: ColorList.white,
                      textColor: ColorList.black,
                      messageIcon: imageCloseRed,
                      closeWidget: Image.asset(
                        imageClose,
                        color: ColorList.black,
                      ),
                    ));
                // showToast(state.message!);
              } else if (state is ApiLoadingState) {
                if (!isDialogShowing && ModalRoute.of(context)!.isCurrent) {
                  showDialogView();
                }
              } else if (state is ApiLoadedState && isDialogShowing) {
                hideDialog();
              }
            },
          ),
        ],
        child: getCustomBloc(),
      );

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  Widget getCustomBloc();

  void onBackPressed() => goBack(context, route: runtimeType.toString());

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> showDialogView() async {
    if (isDialogShowing) {
      return;
    }
    isDialogShowing = true;
    await loadingDialog(
      context: context,
    );
  }

  hideDialog() {
    if (isDialogShowing) {
      isDialogShowing = false;
    }
    if (isBottomSheet) {
      isBottomSheet = false;
    }
    goBack(context, route: runtimeType.toString());
  }

  goToDashboard() {
    navigateAndRemoveAll(context, Routes.dashboard, Routes.dashboard);
  }

  bool isBottomSheet = false;

  void showBottomSheetWidget(
    Widget widget, {
    bool isDismissible = false,
    bool enableDrag = true,
  }) {
    isBottomSheet = true;
    Future<dynamic> bottomSheet = showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (BuildContext buildContext) {
        return Wrap(
          children: <Widget>[
            widget,
          ],
        );
      },
    );
    bottomSheet.then((value) => isBottomSheet = false);
  }

  Widget emptyWidget() => const Center(
        child: Text(labelNoDataFound),
      );
}
