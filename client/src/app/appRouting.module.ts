import { NgModule } from '@angular/core';
import { LandingpageComponent } from './landingpage/landingpage.component';
import { CookbookComponent } from './cookbook/cookbook.component';
import { RecipeComponent } from './recipe/recipe.component';
import { Routes, RouterModule } from '@angular/router';

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
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
