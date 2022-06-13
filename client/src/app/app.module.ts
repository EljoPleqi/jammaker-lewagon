import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { LandingpageComponent } from './landingpage/landingpage.component';
import { HeaderComponent } from './landingpage/header/header.component';
import { SpotifyButtonComponent } from './landingpage/spotify-button/spotify-button.component';
import { CookbookComponent } from './cookbook/cookbook.component';
import { SidebarComponent } from './cookbook/sidebar/sidebar.component';
import { InputFieldComponent } from './cookbook/input-field/input-field.component';
import { RecipesComponent } from './cookbook/recipes/recipes.component';
import { RecipeCardComponent } from './cookbook/recipes/recipe-card/recipe-card.component';
import { UserInfoComponent } from './cookbook/sidebar/user-info/user-info.component';

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
    RecipeCardComponent,
    UserInfoComponent,
  ],
  imports: [BrowserModule],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
