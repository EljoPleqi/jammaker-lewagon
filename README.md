Jammaker is a small tool designed to help you create playlists that last as long as the total length of the recipe, build with ruby on rails

how to run locally 
  1. Clone the repo
  2. Create an app on https://developer.spotify.com/dashboard/
  3. while being in the project folder run:
    ```
    bundle install
    yarn add
    ```
  4. Copy your secrets, create an env file and set:
  ```
      SPOTIFY_CLIENT_ID = *your client id*
      SPOTIFY_CLIENT_SECRET = * your client secret
  ```
  6. Open two terminal windows in the one navigate to the project folder and run ```rails s``` and go to https://localhost:3000
  
