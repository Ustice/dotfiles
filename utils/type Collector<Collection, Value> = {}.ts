type Collector<Collection, Value> = {}

declare const pipe: {
  <Value>(value: Value): Valueq
  <A, B>(value: A, fn: (a: A) => B): B
}

declare const toArray: <Value>() => Collector<Value[], Value>

declare const collect: {
  <Collection, Value>(collector: Collector<Collection, Value>): (
    iterable: Iterable<Value>,
  ) => Collection
  <Collection, Value>(
    collector: Collector<Collection, Value>,
    iterable: Iterable<Value>,
  ): Collection
}

const inline = collect(toArray(), [1, 2, 3])
    // ^? unknown[]
const piped = pipe([1, 2, 3], collect(toArray()))
    // ^? number[]

declare const alternateCollect: {
  // Flipped
  <Collection, Value>(iterable: Iterable<Value>): (
    collector: Collector<Collection, Value>
  ) => Collection
  <Collection, Value>(
    // Flipped
    iterable: Iterable<Value>,
    collector: Collector<Collection, Value>,
  ): Collection
}

const inline2 = alternateCollect([1, 2, 3], toArray())
    // ^? number[]
const piped2 = pipe(toArray(), alternateCollect([1, 2, 3]))
    // ^? unknown[]