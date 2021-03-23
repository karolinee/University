function Tree(val, left, right) {
    this.left = left;
    this.right = right;
    this.val = val;
}

Tree.prototype[Symbol.iterator] = function*() {
    let queue = [this]
    while(queue.length) {
        let curr = queue.shift();
        if(curr.left) queue.push(curr.left);
        if(curr.right) queue.push(curr.right)
        yield curr.val;
    }
}

var root = new Tree(1, new Tree (2, new Tree(3)), new Tree(4));

for(var e of root) {
    console.log(e);
}

//jeżeli użylibyśmy stosu to dostaniemy dfs