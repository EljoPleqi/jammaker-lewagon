import { Component, OnInit, OnDestroy } from '@angular/core';
import { UserLoginService } from '../shared/services/user-login.service';
import { Recipe } from '../recipe/Recipe.modal';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-cookbook',
  templateUrl: './cookbook.component.html',
  styleUrls: ['./cookbook.component.css'],
})
export class CookbookComponent implements OnInit, OnDestroy {
  user: any;
  recipes: Recipe[] = [];
  loaded: boolean = false;
  userSub!: Subscription;

  constructor(private userService: UserLoginService) {}

  ngOnInit(): void {
    //   this.userSub = this.userService.getAccessToken().subscribe(); // the subscribe here triggers the http get request and fetches the user
    //   this.user = this.userService.user;
    //   this.recipes = this.userService.recipes;
    //   this.loaded = true;
    //   console.log(this.userService.user);
  }
  ngOnDestroy(): void {
    this.userSub.unsubscribe();
  }
}
