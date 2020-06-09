
abstract class ITestA{

  void Walk();

  void Run();

  void Talk();

  void Fly();

}


abstract class ITestB{

  void Swim();

}


abstract class ATestC{

  void Search();

}

class ImplementedClass extends ATestC implements ITestA, ITestB {
  @override
  void Fly() {
    // TODO: implement Fly
  }

  @override
  void Run() {
    // TODO: implement Run
  }

  @override
  void Swim() {
    // TODO: implement Talk
  }

  @override
  void Walk() {
    // TODO: implement Walk
  }

  @override
  void Talk() {
    // TODO: implement Talk
  }

  @override
  void Search() {
    // TODO: implement Search
  }


}