// app.js
const express = require('express');
const path = require('path');
const app = express();
const port = 3000;

// Serve static files from the 'public' directory
app.use(express.static('public'));

// Define a route to stream an MP3 file
app.get('/stream-mp3', (req, res) => {
  // Path to the MP3 file
  const mp3FilePath = path.join(__dirname, 'public', 'example.ogg');

  // Set the content type to audio/mpeg
  res.set('Content-Type', 'audio/ogg');

  // Stream the MP3 file to the client
  res.sendFile(mp3FilePath);
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
