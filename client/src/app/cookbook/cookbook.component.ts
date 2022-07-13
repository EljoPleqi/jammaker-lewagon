import { Component, OnInit, OnDestroy } from '@angular/core';
import { UserLoginService } from '../shared/services/user-login.service';
import { Recipe } from '../shared/interfaces/recipe.interface';
import { Subscription } from 'rxjs';
import { UserResponse } from '../shared/interfaces/user-response.interface';
import { User } from '../shared/interfaces/user.interface';

@Component({
  selector: 'app-cookbook',
  templateUrl: './cookbook.component.html',
  styleUrls: ['./cookbook.component.css'],
})
export class CookbookComponent implements OnInit, OnDestroy {
  user!: User;
  recipes: Recipe[] = [];
  loading: boolean = true;
  userSub!: Subscription;

  constructor(private userService: UserLoginService) {}

  ngOnInit(): void {
    this.loading = true;
    this.userSub = this.userService
      .getAccessToken()
      .subscribe((data: UserResponse) => {
        this.loading = false;
        this.recipes = data.recipes;
        this.user = data.user;
      });
    // the subscribe here triggers the http get request and fetches the user
  }
  ngOnDestroy(): void {
    this.userSub.unsubscribe();
  }
}
