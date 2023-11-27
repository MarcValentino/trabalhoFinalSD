import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({name: 'artists'})
export class Artist {
  @PrimaryGeneratedColumn()
    artist_id: number;

  @Column({ unique: true })
    artist_name: string;

}
