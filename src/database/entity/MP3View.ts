import { ViewColumn, ViewEntity } from "typeorm"

@ViewEntity({
    expression: `select mm.*, a.artist_name, g.genre_name, a2.album_name  from artists a, albums a2, genres g, mp3_metadata mm 
    where mm.artist_id = a.artist_id and mm.genre_id = g.genre_id 
    and mm.album_id = a2.album_id;`
})

export class MP3View {

    @ViewColumn()
    id: number
    @ViewColumn()
    title: string
    @ViewColumn()
    duration: number
    @ViewColumn()
    filepath: string
    @ViewColumn()
    created_at: Date
    @ViewColumn()
    artist_id: number
    @ViewColumn()
    album_id: number
    @ViewColumn()
    genre_id: number
    @ViewColumn()
    artist_name: string
    @ViewColumn()
    genre_name: string
    @ViewColumn()
    album_name: string
}
