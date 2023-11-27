-- Insert artists
INSERT INTO artists (artist_name) VALUES 
  ('Artist A'), ('Artist B'), ('Artist C'),
  ('Artist D'), ('Artist E'), ('Artist F');

-- Insert albums
INSERT INTO albums (album_name) VALUES 
  ('Album X'), ('Album Y'), ('Album Z'),
  ('Album W'), ('Album V'), ('Album U');

-- Insert genres
INSERT INTO genres (genre_name) VALUES 
  ('Genre Alpha'), ('Genre Beta'), ('Genre Gamma'),
  ('Genre Delta'), ('Genre Epsilon'), ('Genre Zeta');

-- Insert mp3_metadata
INSERT INTO mp3_metadata (title, duration, filepath, artist_id, album_id, genre_id) 
VALUES 
  ('Song Alpha', 240, '/path/to/song_alpha.mp3', 1, 1, 1),
  ('Song Beta', 180, '/path/to/song_beta.mp3', 2, 1, 2),
  ('Song Gamma', 300, '/path/to/song_gamma.mp3', 3, 2, 3),
  ('Song Delta', 200, '/path/to/song_delta.mp3', 4, 3, 1),
  ('Song Epsilon', 240, '/path/to/song_epsilon.mp3', 5, 3, 2),
  ('Song Zeta', 180, '/path/to/song_zeta.mp3', 6, 2, 3);

-- Insert playlists
INSERT INTO playlists (playlist_name) VALUES 
  ('My Favorites'), ('Driving Playlist'), ('Chill Vibes'),
  ('Workout Mix'), ('Study Session'), ('Party Jams');

-- Insert mp3_playlist
INSERT INTO mp3_playlist (mp3_id, playlist_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 2),
  (4, 2),
  (5, 3),
  (6, 3),
  (1, 4),
  (3, 4),
  (5, 5),
  (2, 6),
  (4, 6),
  (6, 6);
