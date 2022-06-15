export class Recipe {
  constructor(
    public title: string,
    public preptime: string,
    public instructions: string,
    public tags: string,
    public ingredients: string,
    public user_id: number,
    public url: string,
    public steps: string,
    public favorite: boolean,
    public category: string,
    public genre: string
  ) {}
}
