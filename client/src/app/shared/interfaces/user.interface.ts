export interface User {
  id: number;
  email: string;
  created_at: Date;
  updated_at: Date;
  image?: any;
  username: string;
  spotify_hash: string;
  avatar: string;
}
