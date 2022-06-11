import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SpotifyButtonComponent } from './spotify-button.component';

describe('SpotifyButtonComponent', () => {
  let component: SpotifyButtonComponent;
  let fixture: ComponentFixture<SpotifyButtonComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ SpotifyButtonComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(SpotifyButtonComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
