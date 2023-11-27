import "reflect-metadata"
import { DataSource } from "typeorm"
import { MP3View } from "../entity/MP3View"
import { Artist } from "../entity/Artist"
import { Album } from "../entity/Album"
import { Genre } from "../entity/Genre"
import { MP3Metadata } from "../entity/MP3Metadata"

export const AppDataSource = new DataSource({
    type: "postgres",
    host: "localhost",
    port: 5432,
    username: "myuser",
    password: "mypassword",
    database: "mydatabase",
    synchronize: false,
    logging: false,
    entities: [MP3View, Artist, Album, Genre, MP3Metadata],
    migrations: [],
    subscribers: [],
})
