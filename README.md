# Geospatial data handling

In this effort, I am going to work with spatial data - collect/create (generate/sample) my own spatial data, visualize it, do queries on it, and visualize the query results.

## Take-aways
* working with spatial data,
* use of a spatial file format and 
* spatial query functions

---

## Step 1

To create (generate) longitude,latitude pairs (ie. spatial coordinates) for 12 locations on the USC campus, in addition to where my home.
The 12, other than home, would have to be spread out across the USC campus
* 3 libraries,
* 3 restaurants/coffee places,
* 3 waterworks (eg. fountains),
* 3 department buidings

## Step 2

Now that I have 13 coordinates and their label strings (ie. text descriptions such as "CS Dept", "BME"), I create a KML file (.kml format, which is XML) out of them. Specifically, each location will be a 'placemark' in the .kml file (with a label, and coords). 

I then use Google Earth to visualize the data in your KML file. You can do a quick check at http://kmlviewer.nsspot.net/ instead.

## Step 3

Download Google Earth on your laptop, install it, bring it up. Load my .kml file into it - that should show you your sampled locations, on Google Earth's globe

## Step 4

Install MySQL on your laptop.

## Step 5

I used MySQL to execute the following two spatial queries:
* computing the convex hull for my 13 points
• computing the four nearest neighbors to my home location

## Step 6

Using OpenLayers (a JavaScript API), I visualized my location data.

## Step 7

Using Tommy Trojan (USC) as the center, compute a set (sequence) of lat-long (ie. spatial) co-ordinates that lie along a pretty Spirograph curve.

For this, I proceeded as follows:
* Create a new KML file with Spirograph curve points
* Convert the KML to an ESRI 'shapefile'
* Visualize the shapefile data using ArcGIS Online

> For the Spirograph curve point creation, I used the following parametric equations (with R=36, r=9, a=30):  
> * x(t) = (R+r)*cos((r/R)*t) - a*cos((1+r/R)*t)  
> * y(t) = (R+r)*sin((r/R)*t) - a*sin((1+r/R)*t)

Payoff - when I do this in KML, what I see is the Spirograph curve superposed on the land imagery - pretty!

---

# Conclusion

I know how to create custom overlays (via KML files containing vector symbols constructed from points, lines and polygons, and its shapefile equivalent) on a map, and perform spatial queries on the underlying data. This can even be the basis for a career :)
