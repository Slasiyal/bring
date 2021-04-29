class SliderModel{
  String title;
  String desc;
  String imageAssetPath;

  SliderModel({this.title, this.desc});

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }
}

List<SliderModel> getSlides(){
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  sliderModel.setTitle('Welcome');
  sliderModel.setDesc('Welcome to Brings App! Buy our Products easily and get access to app only exclusives.');
  sliderModel.setImageAssetPath('assets/onBoarding/firstscreen.png');
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  sliderModel.setTitle('Shopping Bag');
  sliderModel.setDesc('Add products to your shopping cart, and check them out later.' );
  sliderModel.setImageAssetPath('assets/onBoarding/secondscreen.png');
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  sliderModel.setTitle('Search');
  sliderModel.setDesc('Search among 1 million products. The choice is yours.');
  sliderModel.setImageAssetPath('assets/onBoarding/thirdscreen.png');
  slides.add(sliderModel);

  return slides;
}