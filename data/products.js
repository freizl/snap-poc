var tagsColl = db.products;

var x1 = ["Learn your good haskell", "On Lisp",
          "Programming in Scala", "Real world Haskell"];

var objs = x1.map(function (x, index, xs) {
                      return {pid: index+1, pname: x};
                  });

var removeTag = function (x) {
    tagsColl.remove(x);
};
var saveTag = function (x) {
    tagsColl.save(x);
};

objs.forEach(removeTag);
objs.forEach(saveTag);
