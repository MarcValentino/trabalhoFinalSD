import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity({name: 'albums'})
export class Album {
  @PrimaryGeneratedColumn()
    album_id: number;

  @Column({ unique: true })
    album_name: string;

}
