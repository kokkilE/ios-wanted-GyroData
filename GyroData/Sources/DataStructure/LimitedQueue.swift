//
//  LimitedQueue.swift
//  GyroData
//
//  Created by kokkilE on 2023/06/12.
//

struct LimitedQueue<Element> {
    private let maxCount = Int(GyroRecorder.Constant.frequency * 60)
    
    private(set) var head: Node<Element>?
    private(set) var tail: Node<Element>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var count: Int = 0 {
        didSet {
            if count > maxCount {
                head = head?.next
                count -= 1
            }
        }
    }
    
    @discardableResult
    mutating func dequeue() -> Element? {
        if isEmpty { return nil }
        
        let data = head?.data
        head = head?.next
        count -= 1
        
        return data
    }
    
    mutating func enqueue(_ data: Element) {
        let node = Node(data)
        
        if isEmpty {
            head = node
            tail = node
        } else {
            tail?.next = node
            tail = tail?.next
        }
        
        count += 1
    }
    
    mutating func clear() {
        head = nil
        tail = nil
    }
    
    func peek() -> Element? {
        return tail?.data
    }
    
    // for test
    var realCount: Int {
        guard !isEmpty else {
            return 0
        }
        
        var count = 1
        var node = head
        
        while node?.next != nil {
            node = node?.next
            count += 1
        }
        
        return count
    }
}
