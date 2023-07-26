import 'dart:async';

import 'package:complete_advance_course/presentation/base/base_view_moderl.dart';
import 'package:complete_advance_course/presentation/onboarding/onboarding.dart';

import '../../domain/model/model.dart';
import '../resources/app_string.dart';
import '../resources/assets_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutPuts {
  final StreamController _streamController = StreamController<SliderObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    //send this slider data to our view
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) _currentIndex = 0;
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) _currentIndex = (_list.length - 1);
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //  outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

//private functions
  List<SliderObject> _getSliderData() => [
        SliderObject(AppString.onBoardTitle1, AppString.onBoardingSubTitle1,
            ImageAssets.onboardingLogo1),
        SliderObject(AppString.onBoardTitle2, AppString.onBoardingSubTitle2,
            ImageAssets.onboardingLogo2),
        SliderObject(AppString.onBoardTitle3, AppString.onBoardingSubTitle3,
            ImageAssets.onboardingLogo3),
        SliderObject(AppString.onBoardTitle4, AppString.onBoardTitle4,
            ImageAssets.onboardingLogo4),
      ];

  _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

// inputs mean the orders that our view model will receive from our view
mixin OnBoardingViewModelInputs {
  void goNext();
  void goPrevious();
  void onPageChanged(int index);
  Sink
      get inputSliderViewObject; // this is the way to add data to the sream.. stream input
}

//outputs means data or result that will be send from our view model to our view
mixin OnBoardingViewModelOutPuts {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;

  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
