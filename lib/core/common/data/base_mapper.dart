abstract class BaseMapper<E, D> {
  D mapFrom(E type) => Object as D;

  E mapTo(D type) => Object as E;
}
