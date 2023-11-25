import { AppDataSource } from "./database/data-source"
const express = require('express');
const path = require('path');

AppDataSource.initialize().then(async () => {

    /*
    console.log("Inserting a new user into the database...")
    const user = new User()
    user.firstName = "Timber"
    user.lastName = "Saw"
    user.age = 25
    await AppDataSource.manager.save(user)
    console.log("Saved a new user with id: " + user.id)

    console.log("Loading users from the database...")
    const users = await AppDataSource.manager.find(User)
    console.log("Loaded users: ", users)
    */
    const app = express();
    const port = 3000;

    // Serve static files from the 'public' directory
    app.use(express.static('public'));
    app.get('/stream-mp3', (req, res) => {
        const mp3FilePath = path.join(__dirname, 'public', 'example.ogg');
        res.set('Content-Type', 'audio/ogg');
        res.sendFile(mp3FilePath);
    });
    app.listen(port, () => {
        console.log(`Server is running on http://localhost:${port}`);
    });
      
}).catch(error => console.log(error))
