import "reflect-metadata"
import { DataSource } from "typeorm"
import { User } from "./entity/User"

export const AppDataSource = new DataSource({
    type: "postgres",
    host: "postgres_db",
    port: 5432,
    username: "myuser",
    password: "mypassword",
    database: "mydatabase",
    synchronize: true,
    logging: false,
    entities: [],
    migrations: [],
    subscribers: [],
})
