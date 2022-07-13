import { Component, Input, OnInit } from '@angular/core';
import { Recipe } from '../../shared/interfaces/recipe.interface';

@Component({
  selector: 'app-recipes',
  templateUrl: './recipes.component.html',
  styleUrls: ['./recipes.component.css'],
})
export class RecipesComponent implements OnInit {
  @Input() username: string = '';
  @Input() recipes: Recipe[] = [];

  constructor() {}

  ngOnInit(): void {}
}
