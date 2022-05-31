import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["query"];
  token =
    "BQCeAjf9O3HhwWqhgF0c8ExCPmfrMrxFDm36ISS6apB1kT0s5sHws5QXUesFjaBPpKm87WdCcLd7fUw7WDL7XCw64cvGUFviartTgSCYbjoexGx";

  connect() {
    console.log("i am working on line 7");
  }

  getData(e) {
    e.preventDefault();

    fetch("https://api.spotify.com/v1/artists/6wWVKhxIU2cEi0K81v7HvP", {
      method: "GET",
      withCredentials: true,
      credentials: "include",
      headers: {
        Authorization: "Bearer " + this.token,
        "Content-Type": "application/json",
        " Access-Control-Allow-Origin": "http://localhost:3000/",
      },
    }).then((res) => console.log(res));
  }
}
