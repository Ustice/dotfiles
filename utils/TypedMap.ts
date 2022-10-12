const EMPTY: unique symbol = Symbol('empty')
class TypedMap <K, V> extends Map<K, V> {
  #empty: V
  constructor (empty?: V) {
    super()
    this.#empty = empty
  }
  get (key: K): V {
    const value: V = super.get(key)
    return value ?? this.#empty
  }
  set (key: K | null, value: V): this {
    if (key === null) {
      this.#empty = value
      return this
    }

    super.set(key, value)
    return this
  }
  has (key: K): boolean {
    return super.has(key)
  }
  delete (key: K): boolean {
    return super.delete(key)
  }
  clear (): void {
    super.clear()
  }
  forEach (callback: (value: V, key: K, map: Map<K, V>) => void): void {
    super.forEach(callback, this)
  }
  *keys (): Generator<K, void, undefined> {
    yield* super.keys()
  }
  *values (): Generator<V, void, undefined> {
    yield* super.values()
  }
  *entries (): Generator<[ K, V ], void, undefined> {
    yield* super.entries()
  }
  [ Symbol.iterator ](): IterableIterator<[ K, V ]> {
    return super[ Symbol.iterator ]()
  }

  static isA (candidate: unknown): candidate is TypedMap<unknown, unknown> {
    return candidate instanceof TypedMap
  }

  map <MapToType> (
    callback: <ToType extends MapToType>(
      value: V,
      key: K,
      map?: TypedMap<K, ToType>
    ) => ToType,
    defaultValue?: MapToType
  ): TypedMap<K, MapToType> {
    const map: TypedMap<K, MapToType> = new TypedMap<K, MapToType>(
      defaultValue ?? callback(this.#empty, null)
    )
    this.forEach((value, key) => {
      map.set(key, callback(value, key, map))
    })

    return map
  }

  filter <MapToType> (
    callback: <ToType extends MapToType>(
      value: V,
      key: K,
      map?: TypedMap<K, ToType>
    ) => ToType | undefined,
    defaultValue?: MapToType
  ): TypedMap<K, MapToType> {
    const map: TypedMap<K, MapToType> = new TypedMap<K, MapToType>(
      defaultValue ?? callback(this.#empty, null)
    )

    this.forEach((value, key) => {
      const result = callback(value, key, map)

      if (result !== undefined) {
        map.set(key, result)
      }
    })

    return map
  }

  reduce <ReduceToType> (
    reducer: <ToType extends ReduceToType>(
      accumulator: ToType,
      value: V,
      key: K,
      map?: TypedMap<K, V>
    ) => ToType,
    initialValue?: ReduceToType
  ): ReduceToType {
    let accumulator = reducer(initialValue, this.#empty, undefined)

    this.forEach((value, key) => {
      accumulator = reducer(accumulator, value, key, this)
    })
    return accumulator
  }

  static from <Key, Value> (
    iterable: Iterable<[ Key, Value ]>,
    empty?: Value
  ): TypedMap<Key, Value> {
    const map: TypedMap<Key, Value> = new TypedMap<Key, Value>(empty)
    for (const [ key, value ] of iterable) {
      map.set(key, value)
    }
    return map
  }

  static of <Key, Value> (...args: [ Key, Value ][]): TypedMap<Key, Value> {
    const map: TypedMap<Key, Value> = new TypedMap<Key, Value>()
    for (const [ key, value ] of args) {
      map.set(key, value)
    }
    return map
  }

  get size(): number {
    return super.size
  }
  get length(): number {
    return super.size
  }

  at(key: K): V {
    return this.get(key)
  }

  concat (...maps: TypedMap<K, V>[]): TypedMap<K, V> {
    const result = TypedMap.from(this.entries())
    for (const map of maps) {
      map.forEach((value, key) => {
        result.set(key, value)
      })
    }

    return result
  }

  some (callback: (value: V, key: K, map: TypedMap<K, V>) => boolean): boolean {
    for (const [ key, value ] of this.entries()) {
      if (callback(value, key, this)) {
        return true
      }
    }
    return false
  }

  every (callback: (value: V, key: K, map: TypedMap<K, V>) => boolean): boolean {
    for (const [ key, value ] of this.entries()) {
      if (!callback(value, key, this)) {
        return false
      }
    }
    return true
  }

  find (callback: (value: V, key: K, map: TypedMap<K, V>) => boolean): V {
    for (const [ key, value ] of this.entries()) {
      if (callback(value, key, this)) {
        return value
      }
    }
    return undefined
  }

  findIndex (
    callback: (value: V, key: K, map: TypedMap<K, V>) => boolean
  ): K | undefined {
    for (const [ key, value ] of this.entries()) {
      if (callback(value, key, this)) {
        return key
      }
    }
    return undefined
  }

  groupBy (
    callback: (value: V, key: K, map: TypedMap<K, V>) => K
  ): TypedMap<K, TypedMap<K, V>> {
    const result: TypedMap<K, TypedMap<K, V>> = new TypedMap<K, TypedMap<K, V>>(
      new TypedMap<K, V>(this.#empty)
    )
    this.forEach((value, key) => {
      const groupKey = callback(value, key, this)
      const group = result.get(groupKey) ?? new TypedMap<K, V>(this.#empty)
      group.set(key, value)
      result.set(groupKey, group)
    })
    return result
  }

  groupByToMap <NewKey> (
    callback: (value: V, key: K, map: TypedMap<K, V>) => NewKey
  ): TypedMap<NewKey, TypedMap<K, V>> {
    const result = new TypedMap<NewKey, TypedMap<K, V>>(
      new TypedMap<K, V>(this.#empty)
    )
    this.forEach((value, key) => {
      const groupKey = callback(value, key, this)
      const group = result.get(groupKey) ?? new TypedMap<K, V>(this.#empty)
      group.set(key, value)
      result.set(groupKey, group)
    })
    return result
  }

  includes (value: V): boolean {
    return this.some((checkingValue) => checkingValue === value)
  }

  indexOf (value: V): K | undefined {
    for (const [ key, checkingValue ] of this.entries()) {
      if (checkingValue === value) {
        return key
      }
    }
    return undefined
  }
}
