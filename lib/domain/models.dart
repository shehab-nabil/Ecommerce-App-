//onboarding models
class SliderObjectModel {
  String title;
  String subtitle;
  String image;
  SliderObjectModel(
    this.title,
    this.subtitle,
    this.image,
  );
}

class SliderViewObjecModel {
  SliderObjectModel sliderObject;
  int numOfSlides;
  int currentIndex;
  SliderViewObjecModel(
    this.sliderObject,
    this.numOfSlides,
    this.currentIndex,
  );
}
