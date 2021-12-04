-- 1. Create a Songs Table

CREATE TABLE songs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    length FLOAT NOT NULL,
    album_id INT NOT NULL
);
select * from songs;



-- 2. Select only the Names of all the Bands

SELECT name AS band_name
FROM bands;
    
-- 3. Select the Oldest Album
SELECT 
    name AS album_name
FROM
    albums
WHERE
    release_year IS NOT NULL
ORDER BY release_year ASC;



-- 4. Get all Bands that have Albums 

SELECT 
    b.name AS band_name, a.name AS album_name
FROM
    bands b
        JOIN
    albums a ON a.band_id = b.id
GROUP BY a.name;



-- 5. Get all Bands that have No Albums

SELECT 
    b.name AS band_name
FROM
    bands b
WHERE
    id NOT IN (SELECT DISTINCT
            (band_id)
        FROM
            albums a);



-- 6. Get the Longest Album

SELECT 
    s.album_id,
    a.name AS album,
    ROUND(SUM(s.length), 2) AS duration
FROM
    songs s
        JOIN
    albums a ON a.id = s.album_id
GROUP BY s.album_id
ORDER BY duration desc;



-- 7. Update the Release Year of the Album with no Release Year

select * from albums
where release_year is NULL;
#should be 1986

UPDATE albums
SET
	release_year = 1986
 WHERE name = 'Master of Puppets';
 
select * from albums
where release_year is NULL;



-- 8. Get the Average Length of all Songs

SELECT AVG(length) AS average_duration 
FROM songs;


-- 9. Select the longest Song off each Album
SELECT 
    a.name AS album, s.name AS song, MAX(s.length) AS duration
FROM
    songs s
        JOIN
    albums a ON a.id = s.album_id
GROUP BY album_id
ORDER BY duration DESC;



-- 10. Get the number of Songs for each Band
SELECT 
    b.name, COUNT(s.id) AS num_songs
FROM
    albums a
        JOIN
    bands b ON a.band_id = b.id
        JOIN
    songs s ON s.album_id = a.id
GROUP BY a.band_id
ORDER BY num_songs DESC;

