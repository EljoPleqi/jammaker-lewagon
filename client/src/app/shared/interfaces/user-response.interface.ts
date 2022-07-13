import { Recipe } from './recipe.interface';
import { User } from './user.interface';

export interface UserResponse {
  user: User;
  recipes: Recipe[];
}
