import { Instruction } from './instruction.interface';

export interface Recipe {
  id: number;
  title: string;
  preptime: string;
  instructions: Instruction[];
  tags?: any;
  ingredients: string;
  user_id: number;
  created_at: Date;
  updated_at: Date;
  url: string;
  steps: string;
  favorite: boolean;
  category: string;
  genre: string;
}
