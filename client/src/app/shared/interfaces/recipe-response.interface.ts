import { Playlist } from './playlist.interface';
import { Recipe } from './recipe.interface';

export interface RecipeResponse {
  recipe: Recipe;
  playlist: Playlist;
}
