

interface INode<Index, Type> {
  get (index: Index): Type
  set (index: Index, value: Type): void
  has (index: Index): boolean
  delete (index: Index): void
  clear (): void

}

interface IEdge2 <
  A, 
  B,
  IndexA extends Parameters<(indexA: unknown) => A>,
  IndexB extends Parameters<(indexB: unknown) => B>, 
> {
  // mapIndex (indexA: IndexA): IndexB,
  // map (indexA: IndexA): B
}

 abstract class Connection <
  A,
  B,
  IndexA extends Parameters<(indexA: unknown) => A>,
  IndexB extends Parameters<(indexB: unknown) => B>,
  To extends INode<IndexB, B>,
  From extends INode<IndexA, A>
> {
  constructor (
    private map:(indexA: IndexA) => B,
    private mapIndex: (indexA: IndexA) => IndexB,
  ) { }
  get (indexA: IndexA): B {
    return this.map(indexA)
  }

  set (indexA: IndexA, value: B): void {
    const indexB = this.mapIndex(indexA)
    this.to.set(indexB, value)
  }

  get to (index: IndexB): B {
    return this.map(index)
  }

}

class Edge<Index, Type> {
  constructor (
    public from: INode<Index, Type>,
    public to: INode<Index, Type>,
    public weight: number
  ) { }
}

interface IEdge<FromNode extends INode<infer KeyA, infer ValueA>, ToNode extends INode<infer KeyB, infer ValueB>> {
  from: INode<KeyA, ValueA>
  to: INode<KeyB, ValueB
}