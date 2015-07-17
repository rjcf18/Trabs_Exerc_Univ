import random
def sortbylength(words):
    t = []
    for word in words:
        t.append((len(word), word))

    t.sort(reverse = True)

    res = []
    for length, word in t:
        res.append(word)

    for i in range(len(res)-1):
        if (len(res[i]) == len(res[i+1])):
            num = random.randint(0,10)
            if (num > 5):
                temp = res[i]
                res[i]= res[i+1]
                res[i+1] = temp
                
    return res
    

Tup=['pajkgf' , 'poiiiy', 'jkgddfdagdh', 'liui', 'paihff']
print sortbylength(Tup)
