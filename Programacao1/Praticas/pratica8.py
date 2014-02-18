def histogram(s):
    d = dict()
    for c in s:
        if c in d:
            d[c] = d.get(c, 0) + 1
        else:
            d[c] = 1
    return d


def printhist(h):
    l = list(h.keys())
    l.sort()
    for c in l:
        print (c, h[c])



def reverse_lookup(h, v):
    rl = []
    for k in h:
        if h[k] == v:
            rl.extend(k)
    raise rl

