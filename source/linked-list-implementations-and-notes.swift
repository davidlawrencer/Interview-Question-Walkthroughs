import UIKit

//MARK: Final Implementations
final class LLNode<T: Equatable>: Equatable {
    typealias Element = T
    
    public var value: Element
    public var next: LLNode?
    
    init(value: Element) {
        self.value = value
    }
    
    public static func ==(lhs: LLNode, rhs: LLNode) -> Bool {
        return lhs.value == rhs.value
    }
}

class LinkedList<T: Equatable>: CustomStringConvertible {
    typealias Element = T
    typealias Node = LLNode<Element>

    
    // MARK: Properties
    private var head: LLNode<T>?
    private var tail: LLNode<T>?
    private var count = 0
    
    public var numberOfElements: Int {
        return count
    }

    public var isEmpty: Bool {
        return head == nil
    }
    
    public var description: String {
        var name = ""
        var currentNode = head
        while currentNode != nil {
            name += "\(currentNode!.value)"
            if currentNode?.next != nil {
                name += "->"
            }
            currentNode = currentNode?.next
        }
        return name
    }
    
    // MARK: Instance Methods
    public func append(_ value: Element) {
        let node = Node(value: value)
        tail?.next = node
        tail = node
        if isEmpty {
            head = node
        }
        count += 1
    }
    
    public func removeAll(value: Element) {
        var currentNode = head
        var previousNode: Node?
        
        while currentNode != nil {
            if currentNode?.value == value {
                if currentNode?.next == nil {
                    tail = previousNode
                }

                if previousNode == nil {
                    head = currentNode?.next
                } else {
                    previousNode?.next = currentNode?.next
                }

                count -= 1
            }
            previousNode = currentNode
            currentNode = currentNode?.next
        }
    }
    
    public func reversed() -> LinkedList {
        var stack = Array<Element>()
        var currentNode = head
        while currentNode != nil {
            stack.append(currentNode!.value)
            currentNode = currentNode?.next
        }

        let newLinkedList = LinkedList()
        while !stack.isEmpty {
            if let last = stack.popLast() {
                newLinkedList.append(last)
            }
        }
        return newLinkedList
    }
    
    subscript(index: Int) -> Element? {
        var currentNode = head
        var currentIndex = 0
        while currentNode?.next != nil {
            if currentIndex == index {
                return currentNode?.value
            }
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return nil
    }
}




//MARK: Implementations with Notes




/*
// why was this a class? a reference type, where a struct would be a value type.
// 1 -> 2 needs 1's next needs to be a reference type, so then 1 would need to be a reference type.
final class LLNode<T: Equatable>: Equatable {
    typealias Element = T
    
    public var value: Element
    public var next: LLNode?
    
    init(value: Element) {
        self.value = value
    }
    
    public static func ==(lhs: LLNode, rhs: LLNode) -> Bool {
        return lhs.value == rhs.value
    }
}
/*
 Define a LinkedList (did this used to say struct?) that
 has properties head, tail,count, and isEmpty
 add instance methods append(value:T), which adds at the end of the list, remove(value:T) which removes ALL nodes that match a specific value, and
 reversed , which returns a Linked List with its nodes in the opposite order of the original LL
 */

// let's make sure the elements are generically equatable. LL is made up of nodes, those nodes hold values.
// For LL and for its nodes (and for really any data type) we want to hide the implementation as much as possible. If I don't know anything about LL but still want to store stuff in one, your LL should be as user-friendly of an interface as I would expect.

// ALWAYS USE VALUE TYPES*
// Except in some cases -> all mutation in our object is in reference types, it would be good if the object itself was a reference type.
class LinkedList<T: Equatable>: CustomStringConvertible {
    // typealias - remember these names only exist within the scope of our class
    typealias Element = T // LinkedList.Element == T
    typealias Node = LLNode<Element> // LinkedList.Node == LLNode<Element> == LLNode<T>

    
    // MARK: Properties
    
    // head is a node -> very first node
    // head is a standard property for almost every linked list
    // private because we only want head to be modified by the instance methods we're creating below
    private var head: LLNode<T>? // this starts nil, so there's no first node. we create an empty list by default
    
    // tail is a node -> last node
    // the case for tail:
    // say there were n number of nodes. how long would it take to find the end of the list or to add to the end of the list by starting at head? O(n)
    // by having tail, we can just use that reference to add/look up in O(1) time
    // private for same reason as head
    private var tail: LLNode<T>? // this starts nil, so there's no last node
    
    
    // count is an Int telling us how many nodes are in the LL
    // without count, we would have to look at O(n) nodes to know how many there are (gotta count em all)
    // with count, O(1)
    // private because our instance methods do the work to increase/decrease it
    private var count = 0 // in each of our functions, we'll have to make sure we are tracking +/- from count
    
    // create only a public getter, with no ability to mess with the count property
    public var numberOfElements: Int {
        return count
    }

    
    // isEmpty -> how do we know when our LL is empty? head is nil
    public var isEmpty: Bool {
        // if !isEmpty, do stuff
        return head == nil
    }
    
    // conform to CustomStringConvertible
    public var description: String {
        var name = ""
        var currentNode = head
        // look until currentNode is nil to make sure i get to the end
        while currentNode != nil {
            name += "\(currentNode!.value)"
            // huh? why did we do this -> don't want an arrow after tail
            if currentNode?.next != nil {
                name += "->"
            }
            currentNode = currentNode?.next
        }
        return name
    }
    
    // MARK: Instance Methods
    
    // append value -> changes our list, don't return anything
    public func append(_ value: Element) {
        let node = Node(value: value)
        // 1 -> 2 -> 3 -> 4 and I want to add 5, I can just say 5 is the tail, because it's not linked to the other nodes yet.
        
        // 1. connect the 4 to the 5 (create the arrow)
        // 2. when we're looking for tail, we should be looking at 5. tail.next should always be nil
        tail?.next = node // what happens if tail is nil currently? nothing in LL, so optional chaining will fail
        tail = node   // logically same as tail = tail.next
        
        // if there's no head (if it's empty), make it this node
        if isEmpty {
            head = node
        }
        count += 1
    }
    
    // job is to remove all nodes that have the value argument here
    public func removeAll(value: Element) {
        // keep in mind: setting up head, setting up tail, count
        // would be pretty dang easy if we just had head, with no other properties
        
        // LL1: 1 -> 2 -> 3 -> 4 -> 5
        // we don't have to worry about head, we don't have to worry about tail
        // how many nodes will be left if we remove the value 3?
        // 4: 1 -> 2 -> 4 -> 5
        
        // LL2: 10 -> 3 -> 10 -> 4 -> 10
        // we have to worry about head, we have to worry about tail, and we're removing more than one if we remove the value 10
        // how many nodes will be left if we remove the value 10
        // 2: 3 -> 4
        
        // look through each node starting at head
        var currentNode = head
        // keeps track of the node we saw before. starts as nil because technically there's nothing before head
        var previousNode: Node?
        
        while currentNode != nil {
            //do some stuff
            // if currentNode does not have the value, we'll just move on
            if currentNode?.value == value {
                // current node has the value, and the way that we reassign  connections between nodes is by reassigning the reference to that node
                // head is beginning, tail is end, node.next is to reassign connections in nodes in the middle
                
                //check if it's tail
                if currentNode?.next == nil {
                    // we wanna know the previous node
                    // we'll have to set the last one we saw before this node as the tail
                    tail = previousNode
                }
                
                //check if it's head -> previous node is nil
                // LL2: 10 -> 3 -> 10 -> 4 -> 10
                // head is now 3 -> 10 -> 4 -> 10
                if previousNode == nil {
                    // head = head?.next will also work here
                    head = currentNode?.next
                } else {
                    // reassign something!!!
                    // 3 -> 10 -> 4 -> 10
                    // previousNode is head (3) and its next is Node(10)
                    // currentNode is head.next (10) and its next is Node(4)
                    previousNode?.next = currentNode?.next
                    // what this does is get us the intermediate 3 -> 4 -> 10
                    // because there is no longer a reference to the node that was currentNode (holding 10), this node will be deallocated (TY ARC) once we exit the scope
                }
                
                // decrement the count
                count -= 1
            }
            previousNode = currentNode
            currentNode = currentNode?.next
        }
    }
    
    // CLASS TODO: Reversed - give me back a linked list that has the nodes of this instance but in reverse order
    public func reversed() -> LinkedList {
        // my array here is a stack -> in a stack, we only want to look at one spot
        // we simulate here by looking at the last index to add/remove/peek
        var stack = Array<Element>()
        // array.append is push, popLast is pop, last is peek, isEmpty is isEmpty
        
        // put all values in a stack: get each item starting from head and push into stack
        // 1 -> 2 -> 3 -> 4 -> 5
        var currentNode = head
        // to iterate through a linked list, we just keep going until currentNode is nil
        while currentNode != nil {
            // how do we iterate or go down the line in the list? reassign currentNode until it's nil
            // reassign to currentNode.next -> going to change the instance we're in eventually get to tail
            stack.append(currentNode!.value)
            currentNode = currentNode?.next
        }
        // at the end of this while loop, the value from which node is going to be available?
        // the value from the tail will be at the top of our stack
        
        // in the new LL: pop and append them to the new LL (functionality already exists)
        let newLinkedList = LinkedList()
        while !stack.isEmpty {
            if let last = stack.popLast() {
                newLinkedList.append(last)
            }
        }
        return newLinkedList
        // stack and currentNode get deinitialized because ARC gets rid of everything declared in this scope
    }
    
    // want to mutate the linked list? for the current instance, put all the nodes in reverse order
    // func reverse() {} // remember naming conventions

    // stretch: set up subscript that you define to look for indexes (if LL[0] = head)
    subscript(index: Int) -> Element? { //optional return so that we can return nil if the nth node doesnt exist
        // starting at the head, while loop that looks at currentNode.next (to see if it is last) and compares it to some kind of counter
        var currentNode = head
        var currentIndex = 0
        while currentNode?.next != nil {
            if currentIndex == index {
                return currentNode?.value
            }
            currentNode = currentNode?.next
            currentIndex += 1
        }
        // the count is not equal to or larger than the index
        return nil
    }
}
*/
