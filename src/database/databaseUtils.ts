import { AppDataSource } from "./config/data-source";
import path from "path";
import fs from "fs";
import { readMp3FolderAndSaveToDB } from "./migration/readMusicFolder";
import { DataSource } from "typeorm";

export async function initializeConnection() {
  const connectionEstablished = false;
  while(!connectionEstablished){
    try{
      console.log("Attempting to connect...");
      const connection = await AppDataSource.initialize();
      console.log("Connection successful!");
      return connection;
    } catch(error){
      console.log("error connecting: ", error);
      console.log("retrying...");
    }
  }
}

export async function seedDatabase(connection: DataSource) {
  try{
    const createDatabaseSQL = fs.readFileSync(path.join(__dirname, 'sql/create_database.sql')).toString();
    console.log(createDatabaseSQL);
    await connection.query(createDatabaseSQL);
    await readMp3FolderAndSaveToDB(path.join(__dirname, '../public'), connection);
    console.log('Seeding successful!');
  } catch(error) {
    console.error("error while seeding: ", error);
  }
    
}