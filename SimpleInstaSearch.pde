// Based on a sketch by forum.processing.org forum user newmiracle

JSONObject jsonAgram;
int a, b;

PImage displayInstaImage1;

String apiKey = "xxxxxxxxx"; // insert valid API key
String tagSearch;

void setup() {
  println("setup");
  frameRate(4);

  size(1280, 640);
  tagSearch = "pizza";
}

void draw() {
  
  loadData();
  
  for (int a = 0; a <= 1280; a = a+320) {
    for (int b = 0; b <= 320; b = b+320) {
    loadData();
    image(displayInstaImage1, a, b);
    }
  }
}


void loadData() {

  jsonAgram = loadJSONObject("https://api.instagram.com/v1/tags/"+tagSearch+"/media/recent?count=10&access_token="+apiKey);

  JSONArray instagramData = jsonAgram.getJSONArray("data");
  println(instagramData);

    JSONObject entry1 = instagramData.getJSONObject(5);
    JSONObject image1Data = entry1.getJSONObject("images").getJSONObject("low_resolution"); 

    String image1URL = image1Data.getString("url");

    displayInstaImage1 = loadImage(image1URL, "png");
  
}
