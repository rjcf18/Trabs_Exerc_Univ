-- 1 ---------------------------------------

data Lista a = Vazia
              | Cons a (Lista a)
               deriving (Show)

tamanho :: Lista a -> Int
tamanho Vazia = 0
tamanho (Cons _ l) = 1 + tamanho(l)

elementos :: Lista a -> [a]
elementos Vazia = []
elementos (Cons a l) = [a] ++ elementos(l)


-- 2 ---------------------------------------

last_el :: [Integer] -> Integer
last_el [x] = x
last_el (_:xs) = last_el xs

tamanho2 :: [a] -> Int
tamanho2 [] = 0
tamanho2 (a:as) = 1 + tamanho2(as)

inverte :: [a] -> [a]
inverte [] = []
inverte (a:as) = inverte(as) ++ [a]

inverte2 :: [a] -> [a]
inverte2 l = inv_aux l []

inv_aux :: [a] -> [a] -> [a]
inv_aux [] l = l
inv_aux (x:xs) acc = inv_aux xs (x:acc)

factorial :: Int -> Int
factorial 1 = 1
factorial a = a*factorial(a-1)

ordenada :: [Integer] -> Bool
ordenada [] = True
ordenada (x:[]) = True
ordenada (x:xs) = x <= head xs && ordenada(xs)

duplica :: [a] -> [a]
duplica [] = []
duplica (x:xs) = [x,x]++duplica(xs)

------------------------------------------------------------------------------

applyTwice :: (a -> a) -> a -> a
applyTwice f a = f (f a)

map1 :: (a->b) -> [a] -> [b]
map1 f [] = []
map1 f (x:xs) = f x : map1 f xs

quadrados :: [Integer] -> [Integer]
quadrados l1 = map1 (\x -> x*x) l1

heads :: [[a]]->[a]
heads xs = map1 head xs

data Tree a = Empty
              | Leaf a
              | Node (Tree a) a (Tree a)
              deriving Show

num_elementos :: Tree a -> Integer
num_elementos Empty = 0
num_elementos (Leaf a) = 1
num_elementos (Node x y z) = 1 + num_elementos x + num_elementos z

max_list :: [Integer] -> Integer
max_list (x:xs) = foldr max x xs
