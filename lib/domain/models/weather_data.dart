class WeatherData {
  final int timepoint;
  final int cloudcover;
  final int seeing;
  final int transparency;
  final int liftedIndex;
  final int rh2m;
  final int temp2m;
  final String precType;
  WeatherData({
    required this.timepoint,
    required this.cloudcover,
    required this.seeing,
    required this.transparency,
    required this.liftedIndex,
    required this.rh2m,
    required this.temp2m,
    required this.precType,
  });

  factory WeatherData.fromJson(Map data) {
    return WeatherData(
      timepoint: data['timepoint'],
      cloudcover: data['cloudcover'],
      seeing: data['seeing'],
      // //TypeError (type 'Null' is not a subtype of type 'int')
      transparency: data['transparency'],
      liftedIndex: data['lifted_index'],
      rh2m: data['rh2m'],
      temp2m: data['temp2m'],
      precType: data['prec_type'],
    );
  }
}


    // "dataseries" data['
    // {
    // "timepoint" : 3, //Local time
    // "cloudcover" : 9, //Cloud Amount
    // "seeing" : 3, //Astro Seeing
    // "transparency" : 8, //Transparency
    // "lifted_index" : 2, 
    // "rh2m" : 15, 
    // "wind10m" : { 
    //     "direction" : "W", 
    //     "speed" : 2
    // },
    // "temp2m" : 15, //2m Temp
    // "prec_type" : "rain" //Precipitation
    // },