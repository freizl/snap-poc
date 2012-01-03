var tagsColl = db.tags;

var x1 = ["Haskell", "CommonLisp", "Scala"];
var objs = x1.map(function (x, index, xs) {
                      return {tid: index, name: x};
                  });

var removeTag = function (x) {
    tagsColl.remove(x);
};
var saveTag = function (x) {
    tagsColl.save(x);
};

objs.forEach(removeTag);
objs.forEach(saveTag);
