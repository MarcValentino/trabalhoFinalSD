import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({name: 'genres'})
export class Genre {
  @PrimaryGeneratedColumn()
    genre_id: number;

  @Column({ unique: true })
    genre_name: string;

}
