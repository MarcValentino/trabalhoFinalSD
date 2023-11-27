import * as fs from 'fs';
import * as path from 'path';
import * as mm from 'music-metadata';
import { DataSource } from 'typeorm';
import { Artist, Genre, MP3Metadata, Album } from '../entity';

interface MP3FileData {
  title?: string;
  artist?: string;
  album?: string;
  genre?: string;
  duration?: number;
  filepath?: string;
}

export async function readMp3FolderAndSaveToDB(folderPath: string, connection: DataSource): Promise<void> {

  const files = fs.readdirSync(folderPath);

  for (const file of files) {
    const filePath = path.join(folderPath, file);

    try {
      const metadata = await mm.parseFile(filePath, { duration: true });

      const mp3Metadata: MP3FileData = {
        title: metadata.common.title ? metadata.common.title : 'untitled',
        artist: metadata.common.artist ? metadata.common.artist : 'unknown',
        album: metadata.common.album ? metadata.common.album : 'unknown',
        genre: metadata.common.genre ? metadata.common.genre[0] : undefined,
        duration: Math.floor(metadata.format.duration),
        filepath: filePath,
      };

      await saveMp3MetadataToDB(mp3Metadata, connection);
    } catch (error) {
      console.error(`Error reading metadata for file ${filePath}:`, error.message);
      throw error;
    }
  }
}

async function saveMp3MetadataToDB(metadata: MP3FileData, connection: DataSource): Promise<void> {
  const mp3Repository = connection.getRepository(MP3Metadata);
  const artistRepository = connection.getRepository(Artist);
  const albumRepository = connection.getRepository(Album);
  const genreRepository = connection.getRepository(Genre);

  const artist = await artistRepository.findOne({ where: { artist_name: metadata.artist } }) || await artistRepository.save({ artist_name: metadata.artist });
  const album = await albumRepository.findOne({ where: { album_name: metadata.album } }) || await albumRepository.save({ album_name: metadata.album });
  const genre = await genreRepository.findOne({ where: { genre_name: metadata.genre } }) || await genreRepository.save({ genre_name: metadata.genre });

  const mp3 = new MP3Metadata();
  mp3.title = metadata.title;
  mp3.duration = metadata.duration;
  mp3.filepath = metadata.filepath;
  mp3.artist = artist;
  mp3.album = album;
  mp3.genre = genre;

  await mp3Repository.save(mp3);
}
