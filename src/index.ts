import { MP3View } from "./database/entity";
import express from 'express';
import { initializeConnection, seedDatabase } from "./database/databaseUtils";

initializeConnection().then(async connection => {
  await seedDatabase(connection);
  const app = express();
  const port = 3000;

  app.use(express.static('public'));

  app.get('/get-all-mp3', async (req, res) => {
    try {
      const files = await connection.getRepository(MP3View).createQueryBuilder()
        .select(['id', 'title', 'duration', 'artist_name', 'album_name'])
        .distinct()
        .orderBy('id', 'ASC')
        .execute();
            
      res.json({result: files});
    } catch(error){
      console.log("error: ", error);
      res.status(500);
    }
  });

  app.get('/stream-mp3/:mp3Id', async (req, res) => {
    try {
      const mp3Id = +req.params.mp3Id;
      const file = await connection.getRepository(MP3View).findOne({
        select: {
          filepath: true
        },
        where: {
          id: mp3Id,
        }});
      const mp3FilePath = file.filepath;
      res.set('Content-Type', 'audio/mpeg');
      res.sendFile(mp3FilePath);
    } catch(error) {
      console.log("error", error);
      res.status(500);
    }
  });

  app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
  });
});