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

CREATE TABLE if not exists playlists (
    playlist_id SERIAL PRIMARY KEY,
    playlist_name VARCHAR(255) UNIQUE
);

CREATE TABLE if not exists mp3_playlist (
    mp3_playlist_id SERIAL PRIMARY KEY,
    mp3_id INT,
    playlist_id INT,
    FOREIGN KEY (mp3_id) REFERENCES mp3_metadata(id),
    FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id)
);
