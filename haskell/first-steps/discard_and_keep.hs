-- Use list generators is really easy :)

discard :: (a -> Bool) -> [a] -> [a]
discard fn items = [x|x<- items, not (fn x)]

keep :: (a -> Bool) -> [a] -> [a]
keep fn items = [x|x<-items,fn x]