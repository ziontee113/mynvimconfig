class Product {
  constructor(name, color, size) {
    this.name = name;
    this.color = color;
    this.size = size;
  }
  simpleFunction() {
    return `${this.name} ${this.color} ${this.size}`;
  }
  sipersimplefunction() {
    return `${this.name} ${this.color} ${this.size}`;
  }
}

let apple = new Product("Apple", "red", "small");
let tree = new Product("Tree", "green", "large");
let house = new Product("House", "blue", "huge");

let stop = "Stop";
