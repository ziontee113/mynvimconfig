class Person {
  constructor(name) {
    this.name = name;
  }

  walk() {
    console.log(`${this.name} is walking`);
  }
}

class Teacher extends Person {
  constructor(name, subject) {
    super(name);
    this.subject = subject;
  }

  teach() {
    console.log(`${this.name} is teaching ${this.subject}`);
  }
}

const teacher = new Teacher("John", "math");
teacher.teach();

teacher.walk();
