-- I have used MySQL database for these queries as it has the spatial plugin built-in

DROP DATABASE IF EXISTS ishaan_test_hw3;
CREATE DATABASE ishaan_test_hw3;
USE ishaan_test_hw3;

/*
 4326 is the most common spatial reference for storing a referencing data across the entire world.
 It serves as the default for both the PostGIS spatial database and the GeoJSON standard.
 It is also used by default in most web mapping libraries.
 Because of its use in GPS, 4326 is generally assumed to be the spatial reference when talking about "lat" or "long".
 */

 -- table creation
CREATE TABLE locations
(
    id          INTEGER AUTO_INCREMENT PRIMARY KEY,
    folder      VARCHAR(100) NOT NULL,
    label       VARCHAR(300) NOT NULL,
    coordinates POINT        NOT NULL SRID 4326,
    SPATIAL INDEX (coordinates)
);

-- data insertion commands

INSERT INTO locations (folder, coordinates, label)
VALUES ('Home', ST_GeomFromText('POINT(34.0325022 -118.2820358)', 4326), 'Home');

INSERT INTO locations (folder, coordinates, label)
VALUES ('Libraries', ST_GeomFromText('POINT(34.021212 -118.2836744)', 4326), 'Library for International and Public Affairs');
INSERT INTO locations (folder, coordinates, label)
VALUES ('Libraries', ST_GeomFromText('POINT(34.0215009 -118.2830803)', 4326), 'Leavey Library');
INSERT INTO locations (folder, coordinates, label)
VALUES ('Libraries', ST_GeomFromText('POINT(34.0204552 -118.2841838)', 4326), 'Edward Doheny Jr Memorial Library');

INSERT INTO locations (folder, coordinates, label)
VALUES ('Waterworks', ST_GeomFromText('POINT(34.0206175 -118.2842202)', 4326), 'Prentiss Memorial Fountain');
INSERT INTO locations (folder, coordinates, label)
VALUES ('Waterworks', ST_GeomFromText('POINT(34.0220509 -118.2832533)', 4326), 'Generations Fountain');
INSERT INTO locations (folder, coordinates, label)
VALUES ('Waterworks', ST_GeomFromText('POINT(34.0173607 -118.2861791)', 4326), 'Exposition Park Fountain');

INSERT INTO locations (folder, coordinates, label)
VALUES ('Eateries', ST_GeomFromText('POINT(34.0198434 -118.285959)', 4326), 'Moreton Fig');
INSERT INTO locations (folder, coordinates, label)
VALUES ('Eateries', ST_GeomFromText('POINT(34.0202816 -118.2859152)', 4326), 'Panda Express');
INSERT INTO locations (folder, coordinates, label)
VALUES ('Eateries', ST_GeomFromText('POINT(34.0188652 -118.2910767)', 4326), 'Parkside Restaurant');

INSERT INTO locations (folder, coordinates, label)
VALUES ('Departments', ST_GeomFromText('POINT(34.0209376 -118.2896411)', 4326), 'Department of Public Safety');
INSERT INTO locations (folder, coordinates, label)
VALUES ('Departments', ST_GeomFromText('POINT(34.0203924 -118.2937717)', 4326),
        'Ethel Percy Andrus Gerontology Center');
INSERT INTO locations (folder, coordinates, label)
VALUES ('Departments', ST_GeomFromText('POINT(34.0197308 -118.2901050)', 4326),
        'Hughes Aircraft Electrical Engineering Center');

-- getting the convex hull of all points in the table
SELECT ST_AsText(ST_ConvexHull(ST_Union(
        ST_GeomFromText(
                concat('GEOMETRYCOLLECTION(', GROUP_CONCAT(ST_AsText(coordinates)), ')')
        ), ST_GeomFromText('GEOMETRYCOLLECTION EMPTY')
                               ))) as convex_hull_polygon
FROM locations;

-- getting 4 nearest neighbours from home
SET @home = (SELECT coordinates
             FROM locations
             where label = "Home");
SELECT folder, label, ST_AsText(coordinates), ST_Distance(coordinates, @home) AS Distance_from_Home_in_degree_of_arc
FROM locations
WHERE label <> "Home"
ORDER BY Distance_from_Home_in_degree_of_arc
LIMIT 4;
