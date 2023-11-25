import { AppDataSource } from "./database/config/data-source"
import { MP3View } from "./database/entity/MP3View";
import express from 'express';
import path from 'path';

AppDataSource
    .initialize()
    .then(() => {
        console.log("Data Source has been initialized!")
    })
    .catch((err) => {
        console.error("Error during Data Source initialization:", err)
})

const app = express();
const port = 3000;

// Serve static files from the 'public' directory
app.use(express.static('public'));

app.get('/get-all-mp3', async (req, res) => {
    try {
        const files = await AppDataSource.getRepository(MP3View).createQueryBuilder()
            .select(['id', 'title', 'duration', 'artist_name', 'album_name'])
            .distinct()
            .execute();
        
        res.json({result: files});
    } catch(error){
        console.log("error: ", error);
        res.status(500);
    }
})

app.get('/stream-mp3/:mp3Id', async (req, res) => {
    try {
        const mp3Id = +req.params.mp3Id;
        const file = await AppDataSource.getRepository(MP3View).findOne({
        select: {
            filepath: true
        },
        where: {
            id: mp3Id,
        }});
        const mp3FilePath = path.join(__dirname, 'public', file.filepath);
        res.set('Content-Type', 'audio/ogg');
        res.sendFile(mp3FilePath);
    } catch(error) {
        console.log("error", error);
        res.status(500);
    }
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
