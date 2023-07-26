import 'package:complete_advance_course/presentation/onboarding/onboarding_view_model.dart';
import 'package:complete_advance_course/presentation/resources/app_string.dart';
import 'package:complete_advance_course/presentation/resources/assets_manager.dart';
import 'package:complete_advance_course/presentation/resources/color_manager.dart';
import 'package:complete_advance_course/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/model/model.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({super.key});

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  final _pageController = PageController(initialPage: 0);

  OnBoardingViewModel _viewModel = OnBoardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidgets(snapshot.data);
        });
  }

  Widget _getContentWidgets(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark),
        ),
        body: PageView.builder(
            controller: _pageController,
            itemCount: sliderViewObject.numOfSlides,
            onPageChanged: (index) {
              _viewModel.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return OnBoardingPage(sliderViewObject.sliderObject);
            }),
        bottomSheet: Container(
          color: ColorManager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        AppString.skip,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleSmall,
                      ))),
              _getBottomSheetWidgets(sliderViewObject),
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidgets(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: GestureDetector(
                child: SizedBox(
                  height: AppSize.s20,
                  width: AppSize.s20,
                  child: SvgPicture.asset(
                    ImageAssets.leftArrowIc,
                    height: 200,
                    width: 200,
                  ),
                ),
                onTap: () {
                  _pageController.animateToPage(_viewModel.goPrevious(),
                      duration:
                          const Duration(milliseconds: DurationConstant.d300),
                      curve: Curves.bounceInOut);
                },
              )),
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                Padding(
                  padding: EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                )
            ],
          ),
          //next
          Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: GestureDetector(
                child: SizedBox(
                  height: AppSize.s20,
                  width: AppSize.s20,
                  child: SvgPicture.asset(ImageAssets.rightArrowIc),
                ),
                onTap: () {
                  _pageController.animateToPage(_viewModel.goNext(),
                      duration:
                          const Duration(milliseconds: DurationConstant.d300),
                      curve: Curves.bounceInOut);
                },
              )),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage(this._sliderObject, {super.key});

  SliderObject _sliderObject;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: AppSize.s4),
        Padding(
          padding: EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge),
        ),
        Padding(
          padding: EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.subTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium),
        ),
        SizedBox(height: AppSize.s60),
        //image widget
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}
