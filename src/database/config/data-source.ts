import "reflect-metadata";
import { DataSource } from "typeorm";
import { MP3View, Artist, Album, Genre, MP3Metadata } from "../entity";

export const AppDataSource = new DataSource({
  type: "postgres",
  host: "postgres_db",
  port: 5432,
  username: "myuser",
  password: "mypassword",
  database: "mydatabase",
  synchronize: false,
  logging: false,
  entities: [MP3View, Artist, Album, Genre, MP3Metadata],
  migrations: [],
  subscribers: [],
});
