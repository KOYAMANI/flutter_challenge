## About API

https://www.7timer.info/bin/api.pl?lon={longtitude data}}&lat={latitude data}}&product=astro&output=json;

latitude and longtitude data should be provided as variables

## API response body

response body should be something like this

{
"product" : "astro" ,
"init" : "2021091600" ,
"dataseries" : [
{
"timepoint" : 3, //Local time
"cloudcover" : 9, //Cloud Amount
"seeing" : 3, //Astro Seeing
"transparency" : 8, //Transparency
"lifted_index" : 2,
"rh2m" : 15,
"wind10m" : {
"direction" : "W",
"speed" : 2
},
"temp2m" : 15, //2m Temp
"prec_type" : "rain" //Precipitation
},

    {
    "timepoint" : ...
    "cloudcover" : ...
    "seeing" : ...
    "transparency" : ...
    "lifted_index" : ...
    "rh2m" : ...
    "wind10m" : {
        "direction" : ...
        "speed" : ...
    },
    "temp2m" : ...
    "prec_type" : ...
    },

    ]

},
