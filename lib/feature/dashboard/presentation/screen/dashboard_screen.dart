import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/enums/dashboard_tab_enum.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/dashboard_tab_model.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_state.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/ui/style/app_style.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../routes/routes.dart';
import '../widgets/dashboard_management_widget.dart';

class DashboardScreen extends BaseBlocWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends BaseBlocWidgetState<DashboardScreen>
    with TickerProviderStateMixin {
  StreamController<DashboardTabEnum> currentDashboardStreamController =
      StreamController<DashboardTabEnum>.broadcast();

  DashboardTabEnum currentDashboardTabEnum = DashboardTabEnum.home;

  List<AnimationController> fadeAnimationControllers = [];
  AnimationController? hideAnimationController;

  int previousTabIndex = 0;
  bool isBottomTabHideDisable = true; // hide and disable bottom tab to be show

  @override
  void initState() {
    super.initState();
    fadeAnimationControllers = dashboardTabModels
        .map<AnimationController>((dashboardModel) => AnimationController(
            vsync: this, duration: const Duration(milliseconds: 200)))
        .toList();
    fadeAnimationControllers[currentDashboardTabEnum.getDashboardValue].value =
        1.0;
    hideAnimationController =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);

    hideAnimationController?.forward();
    isBottomTabOpened = true;
  }

  @override
  Widget getCustomBloc() => BlocListener<DashboardBloc, DashboardState>(
        listenWhen: (previousState, state) => state != previousState,
        listener: (context, state) async {
          if (state is ShowEnableBottomScreenState) {
            if (!isBottomTabHideDisable) {
              isBottomTabHideDisable = true;
              hideAnimationController?.forward();
              isBottomTabOpened = true;
            }
          } else if (state is HideDisableBottomScreenState) {
            if (isBottomTabHideDisable) {
              isBottomTabHideDisable = false;
              hideAnimationController?.reverse();
              isBottomTabOpened = false;
            }
          } else if (state is ClearBackStackState) {
            await popUntil(previousTabIndex, removeUntil: state.until);
          }
        },
        child: getChild(),
      );

  Widget getChild() => WillPopScope(
        onWillPop: onWillPop,
        child: StreamBuilder<DashboardTabEnum>(
            initialData: currentDashboardTabEnum,
            stream: currentDashboardStreamController.stream,
            builder: (context, snapshot) {
              currentDashboardTabEnum = snapshot.data ?? DashboardTabEnum.home;
              return NotificationListener<ScrollNotification>(
                  onNotification: _handleScrollNotification,
                  child: Scaffold(
                      backgroundColor: ColorList.white,
                      resizeToAvoidBottomInset: false,
                      appBar: const NoAppBar(),
                      body: Stack(
                        children: <Widget>[
                          SafeArea(
                              child: Stack(
                            fit: StackFit.expand,
                            children: getWidgetList(),
                          )),
                          getBottomNavigationBarWidget(),
                        ],
                      )));
            }),
      );

  List<Widget> getWidgetList() =>
      dashboardTabModels.map((DashboardTabModel dashboardModel) {
        final Widget view = FadeTransition(
          key: UniqueKey(),
          opacity: fadeAnimationControllers[
                  dashboardModel.dashboardTabEnum.getDashboardValue]
              .drive(CurveTween(curve: Curves.fastOutSlowIn)),
          child: KeyedSubtree(
            key: dashboardModel.dashboardKey,
            child: DashboardManagementWidget(
              dashboardModel: dashboardModel,
              // onNavigation: (status) {
              //   if (isNavigation && !status) {
              //     inActive = true;
              //     setBottomListItems(isInactive: true);
              //   } else {
              //     inActive = false;
              //   }
              //   isNavigation = status;
              //   if (isNavigation) {
              //     setBottomListItems();
              //   }
              //   if (isBottomTabHideDisable) {
              //     hideAnimationController?.forward();
              //   }
              // },
            ),
          ),
        );

        if (dashboardModel.dashboardTabEnum == currentDashboardTabEnum) {
          fadeAnimationControllers[
                  dashboardModel.dashboardTabEnum.getDashboardValue]
              .forward();
          isBottomTabOpened = true;
          return view;
        } else {
          fadeAnimationControllers[
                  dashboardModel.dashboardTabEnum.getDashboardValue]
              .reverse();
          isBottomTabOpened = false;
          if (fadeAnimationControllers[
                  dashboardModel.dashboardTabEnum.getDashboardValue]
              .isAnimating) {
            return IgnorePointer(child: view);
          }
          return Offstage(child: view);
        }
      }).toList();

  Widget getBottomNavigationBarWidget() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          child: hideAnimationController != null
              ? SizeTransition(
                  sizeFactor: hideAnimationController!,
                  axisAlignment: -1.0,
                  child: Container(
                    height: dashboardTabHeight,
                    color: ColorList.white,
                    child: Column(
                      children: [
                        Container(
                          color: ColorList.greyLight4Color,
                          width: double.maxFinite,
                          height: 1,
                        ),
                        Expanded(
                          child: StreamBuilder<DashboardTabEnum>(
                              stream: currentDashboardStreamController.stream,
                              builder: (context, snapshot) {
                                return Row(
                                  children: dashboardTabModels
                                      .map((e) =>
                                          Expanded(child: getTabItemWidget(e)))
                                      .toList(),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      );

  Widget getTabItemWidget(DashboardTabModel dashboardTabModel) {
    bool isSelected =
        currentDashboardTabEnum == dashboardTabModel.dashboardTabEnum;
    return GestureDetector(
      onTap: () {
        onClickBottomTab(dashboardTabModel.dashboardTabEnum.getDashboardValue);
      },
      child: AbsorbPointer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(isSelected
                ? dashboardTabModel.iconSelected
                : dashboardTabModel.icon),
            const SizedBox(
              height: 6,
            ),
            Text(
              dashboardTabModel.title,
              style: isSelected
                  ? AppStyle.b9SemiBold.copyWith(color: ColorList.primaryColor)
                  : AppStyle.b9Medium
                      .copyWith(color: ColorList.blackThirdColor),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    bool status =
        !(await dashboardTabModels[currentDashboardTabEnum.getDashboardValue]
                .navigatorKey
                .currentState
                ?.maybePop() ??
            true);
    logger?.d("status $status");
    if (status) {
      if (currentDashboardTabEnum == DashboardTabEnum.home) {
        //   if (!isBackClicked) {
        //     showToast(AppLocalizations.of(context)!
        //         .translate(labelPleaseClickBackAgainToExit));
        //     isBackClicked = true;
        //     Future.delayed(const Duration(seconds: 3), () {
        //       isBackClicked = false;
        //     });
        //     return false;
        //   } else {
        //     return true;
        //   }
        return true;
      } else {
        onClickBottomTab(0);
      }
      return false;
    } else {
      // if (isNavigation) {
      //   setBottomListItems();
      // }
      return false;
    }
  }

  onClickBottomTab(int index1, {bool isCall = false}) async {
    await popUntil(index1);
    currentDashboardTabEnum = index1.dashboardTypeVal();
    currentDashboardStreamController.add(currentDashboardTabEnum);
    logger?.d("onClickBottomTab ${index1.dashboardTypeVal()}");
    switch (index1.dashboardTypeVal()) {
      case DashboardTabEnum.home:
        // BlocProvider.of<FeedBloc>(context).add(ClickOnFeedEvent());
        break;
      case DashboardTabEnum.kolobox:
        // BlocProvider.of<MyTreeBloc>(context).add(ClickOnMyTreeEvent());
        break;
      case DashboardTabEnum.wallet:
        // BlocProvider.of<MapBloc>(context).add(ClickOnMapEvent());
        break;
      case DashboardTabEnum.account:
        // BlocProvider.of<NotificationBloc>(context)
        //     .add(ClickOnNotificationEvent());
        break;
    }
  }

  Future<void> popUntil(int index, {String removeUntil = '/'}) async {
    if (dashboardTabModels[previousTabIndex].navigatorKey.currentState !=
        null) {
      await popUntilWithNavigator(
          dashboardTabModels[previousTabIndex].navigatorKey.currentState!,
          (bool result) async {
        if (result) {
          // await setBottomListItems();
        }
      }, until: removeUntil);
    }

    previousTabIndex = index;
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0 && notification is UserScrollNotification) {
      final UserScrollNotification userScroll = notification;
      switch (userScroll.direction) {
        case ScrollDirection.forward:
          if (isBottomTabHideDisable &&
              userScroll.metrics.axis == Axis.vertical) {
            hideAnimationController?.forward();
            isBottomTabOpened = true;
          }
          break;
        case ScrollDirection.reverse:
          if (isBottomTabHideDisable &&
              userScroll.metrics.axis == Axis.vertical) {
            hideAnimationController?.reverse();
            isBottomTabOpened = false;
          }
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
    currentDashboardStreamController.close();
  }
}
