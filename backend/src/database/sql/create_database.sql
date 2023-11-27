CREATE table if not exists artists (
    artist_id SERIAL PRIMARY KEY,
    artist_name VARCHAR(255) UNIQUE
);

CREATE TABLE if not exists albums (
    album_id SERIAL PRIMARY KEY,
    album_name VARCHAR(255) UNIQUE
);

CREATE TABLE if not exists genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(100) UNIQUE
);

CREATE TABLE if not exists mp3_metadata (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    duration INT,
    filepath VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    artist_id INT,
    album_id INT,
    genre_id INT,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id),
    FOREIGN KEY (album_id) REFERENCES albums(album_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

create or replace view mp3_view as
select mm.*, a.artist_name, g.genre_name, a2.album_name  from artists a, albums a2, genres g, mp3_metadata mm 
where mm.artist_id = a.artist_id and mm.genre_id = g.genre_id 
and mm.album_id = a2.album_id;
