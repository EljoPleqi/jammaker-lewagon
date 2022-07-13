import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { RecipeResponse } from '../interfaces/recipe-response.interface';

@Injectable({
  providedIn: 'root',
})
export class GetRecipeService {
  constructor(private http: HttpClient) {}
  loadRecipe(id: number) {
    return this.http.get<RecipeResponse>(
      `http://localhost:3000/api/recipe/${id}`
    );
  }
}
