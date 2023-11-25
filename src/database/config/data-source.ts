import "reflect-metadata"
import { DataSource } from "typeorm"
import { MP3View } from "../entity/MP3View"

export const AppDataSource = new DataSource({
    type: "postgres",
    host: "postgres_db",
    port: 5432,
    username: "myuser",
    password: "mypassword",
    database: "mydatabase",
    synchronize: true,
    logging: false,
    entities: [MP3View],
    migrations: [],
    subscribers: [],
})
