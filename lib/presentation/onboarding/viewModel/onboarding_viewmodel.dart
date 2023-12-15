import 'dart:async';

import 'package:tut/domain/models/models.dart';
import 'package:tut/presentation/base/base_viewmodel.dart';
import 'package:tut/presentation/resource/assets_manager.dart';
import 'package:tut/presentation/resource/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel {
// stream controllers outputs
  final StreamController _streamController =
      StreamController<SliderViewObjecModel>();
  late final List<SliderObjectModel> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

// inputs ----> the orders that the viewmodel will receive from the view
  int goNextSlide() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) nextIndex = 0;
    return nextIndex;
  }

  int gopreviousSlide() {
    int preIndex = --_currentIndex;
    if (preIndex == -1) preIndex = _list.length - 1;
    return preIndex;
  }

  void onSlideChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  late Sink inputsSliderViewObject = _streamController.sink;

// outputs
  late Stream<SliderViewObjecModel> outputSliderViewObject =
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

// functions
  void _postDataToView() {
    inputsSliderViewObject.add(SliderViewObjecModel(
        _list[_currentIndex], _list.length, _currentIndex));
  }

  List<SliderObjectModel> _getSliderData() => [
        SliderObjectModel(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
        SliderObjectModel(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
        SliderObjectModel(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
        SliderObjectModel(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onboardingLogo4),
      ];
}
