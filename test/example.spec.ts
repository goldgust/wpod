import "mocha"
import { expect } from "chai"
import { Example } from "../src/example";
import { List } from "../src/list";


describe("Example", () => {
  it("Can add 2 numbers", done => {
      let example:Example = new Example()
      let result:number = example.add(1,2)
      expect(result).to.be.equal(3)
    done()
  })

describe("List", () => {
  it("can be created", done => {
      let example:List = new List()
      expect(example).to.be(List())
    done()
  })

})
