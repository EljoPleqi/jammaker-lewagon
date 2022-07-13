import { Component, OnDestroy, OnInit, SecurityContext } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Subscription } from 'rxjs';
import { RecipeResponse } from '../shared/interfaces/recipe-response.interface';
import { GetRecipeService } from '../shared/services/get-recipe.service';
import { DomSanitizer } from '@angular/platform-browser';

@Component({
  selector: 'app-recipe',
  templateUrl: './recipe.component.html',
  styleUrls: ['./recipe.component.css'],
})
export class RecipeComponent implements OnInit, OnDestroy {
  constructor(
    private recipeService: GetRecipeService,
    private route: ActivatedRoute,
    private sanitizer: DomSanitizer
  ) {}

  recipeData!: any;
  recipeSub!: Subscription;
  loaded: boolean = false;
  playlistUrl: string | any = ``;
  ngOnInit(): void {
    const recipeId: number = this.route.snapshot.params['id'];

    this.recipeSub = this.recipeService
      .loadRecipe(recipeId)
      .subscribe((data: RecipeResponse) => {
        this.recipeData = data.recipe;
        this.playlistUrl = this.sanitizer.bypassSecurityTrustResourceUrl(
          `https://open.spotify.com/embed/playlist/${data.playlist.spotify_playlist_id}?utm_source=generator&theme=0`
        );
      });
    this.loaded = true;
  }

  ngOnDestroy(): void {
    this.recipeSub.unsubscribe();
  }
}
