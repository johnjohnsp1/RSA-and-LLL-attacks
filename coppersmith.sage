# INIT
R.<x> = ZZ[]

"""pol is of degree d
NN modulus a multiple of b
lower bound beta, b >= NN^beta
epsilon <= beta / 7
"""
def coppersmith_univariate(pol, NN, bb, beta, epsilon):
    # init
    dd = pol.degree()
    # choose m and t
    mm = ceil(beta**2 / dd * epsilon)
    tt = floor(dd * mm * ((1/beta) - 1))
    # compute polynomials
    gg = {}
    for ii in range(mm):
        gg[ii] = {}
        for jj in range(dd):
            g[ii][jj] = x
    #
    return mm

# TESTS

m = 010101010101 # we know part of the message
ct = 01010101010 # we know the ciphertext
pol = (m - x)**3 - ct

print(coppersmith_univariate(pol, NN, NN, 1, 1))

# TEST 2 of http://www.jscoron.fr/cours/mics3crypto/tpcop.pdf

def keyGen(n=256):
    "Generates an RSA key"
    while True:
        p=random_prime(2^(n//2));q=random_prime(2^(n//2));e=3
        if gcd(e,(p-1)*(q-1))==1: break
    d=inverse_mod(e,(p-1)*(q-1))
    Nn=p*q
    print "p=",p,"q=",q
    print "N=",Nn
    print "Size of N:",Nn.nbits()
    return Nn,p,q,e,d

def CopPolyDeg2(a,b,Nn):
    "Finds a small root of polynomial x^2+ax+b=0 mod N"
    n=Nn.nbits()
    X=2^(n//3-5)
    M=matrix(ZZ,[[X^2,a*X,b],\
                     [0 ,Nn*X,0],\
                     [0 ,0 ,Nn]])
    V=M.LLL()
    v=V[0]

    return [v[i]/X^(2-i) for i in range(3)]

def test():
    """Generates a random polynomial with a small root x0 modulo
    Nn and recovers his root."""
    Nn,p,q,e,d=keyGen()
    n=Nn.nbits()
    x0=ZZ.random_element(2^(n//3-10))
    a=ZZ.random_element(Nn)
    b=mod(-x0^2-a*x0,Nn)
    print "x0=",x0
    v=CopPolyDeg2(a,b,Nn)
    R.<x> = ZZ[]
    f = v[0]*x^2+v[1]*x+v[2]
    print find_root(f, 0,2^(n//3-10))

N = 122840968903324034467344329510307845524745715398875789936591447337206598081

C = 1792963459690600192400355988468130271248171381827462749870651408943993480816