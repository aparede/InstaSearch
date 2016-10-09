// Based on a sketch by forum.processing.org forum user newmiracle

String apiKey = "xxxxxxxxx"; // insert valid API key
String tagSearch;
JSONArray instagramData;
int numPhotos;

void setup() {
  println("setup");
  frameRate(0.2);

  size(1280, 640);
  tagSearch = "pizza";
  instagramData = loadJSONObject("https://api.instagram.com/v1/tags/"+tagSearch+"/media/recent?count=10&access_token="+apiKey).getJSONArray("data");  
  displayImages(instagramData);
}

void draw() {
  
  // check if there's any new data since the last pull, display if there is
  JSONArray instagramDataTemp = loadJSONObject("https://api.instagram.com/v1/tags/"+tagSearch+"/media/recent?count=10&access_token="+apiKey).getJSONArray("data");
  if (!(instagramData.getJSONObject(0).getString("id").equals(instagramDataTemp.getJSONObject(0).getString("id")))) {
    instagramData = instagramDataTemp;
    displayImages(instagramData);
  }
}

void displayImages(JSONArray data) {
  println("refreshed images");
  int numPhotos = data.size();
  PImage[] instaImages = new PImage[numPhotos];
  for (int imgId = 0; imgId < numPhotos; imgId++) {
    instaImages[imgId] = loadImage(data.getJSONObject(imgId).getJSONObject("images").getJSONObject("low_resolution").getString("url"), "png");
  }
  int i = 0;
  for (int a = 0; a <= 1280; a = a+320) {
    for (int b = 0; b <= 320; b = b+320) {
      image(instaImages[i], a, b);
      i++;
      if (i == numPhotos) {i=0;} // start back at index 0 if we get to an element that doesn't exist
    }
  }
}