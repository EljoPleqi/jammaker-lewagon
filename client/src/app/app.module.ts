import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { RouterModule, Routes } from '@angular/router';
import { HttpClientModule } from '@angular/common/http';

import { AppComponent } from './app.component';
import { LandingpageComponent } from './landingpage/landingpage.component';
import { HeaderComponent } from './landingpage/header/header.component';
import { SpotifyButtonComponent } from './landingpage/spotify-button/spotify-button.component';
import { CookbookComponent } from './cookbook/cookbook.component';
import { SidebarComponent } from './cookbook/sidebar/sidebar.component';
import { InputFieldComponent } from './cookbook/input-field/input-field.component';
import { RecipesComponent } from './cookbook/recipes/recipes.component';
import { UserInfoComponent } from './cookbook/sidebar/user-info/user-info.component';
import { RecipeComponent } from './recipe/recipe.component';
import { InstructionCardComponent } from './recipe/instruction-card/instruction-card.component';
import { SpotifyPlayerComponent } from './recipe/spotify-player/spotify-player.component';
import { RecipeCardComponent } from './cookbook/recipes/recipe-card/recipe-card.component';

const routes: Routes = [
  {
    path: '',
    component: LandingpageComponent,
  },
  {
    path: 'auth/spotify/callback',
    component: CookbookComponent,
  },
  {
    path: 'recipe/:id',
    component: RecipeComponent,
  },
];
@NgModule({
  declarations: [
    AppComponent,
    LandingpageComponent,
    HeaderComponent,
    SpotifyButtonComponent,
    CookbookComponent,
    SidebarComponent,
    InputFieldComponent,
    RecipesComponent,
    UserInfoComponent,
    RecipeComponent,
    InstructionCardComponent,
    SpotifyPlayerComponent,
    RecipeCardComponent,
  ],
  imports: [BrowserModule, RouterModule.forRoot(routes), HttpClientModule],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
