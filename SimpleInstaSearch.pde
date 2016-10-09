// Based on a sketch by forum.processing.org user newmiracle

String apiKey = "xxxxxx"; // insert valid API key
String tagSearch;

void setup() {
  println("setup");
  frameRate(0.2);

  size(1280, 640);
  tagSearch = "pizza";
}

void draw() {
  
  JSONArray instagramData = loadJSONObject("https://api.instagram.com/v1/tags/"+tagSearch+"/media/recent?count=10&access_token="+apiKey).getJSONArray("data");
  int numPhotos = instagramData.size(); // check how many photos we got
  String instaImageURL;
  int i = 0;
  for (int a = 0; a <= 1280; a = a+320) {
    for (int b = 0; b <= 320; b = b+320) {
      instaImageURL=instagramData.getJSONObject(i).getJSONObject("images").getJSONObject("low_resolution").getString("url");
      image(loadImage(instaImageURL, "png"), a, b);
      i++;
      if (i == numPhotos) {i=0;} // start back at index 0 if we get to an element that doesn't exist
    }
  }
}
