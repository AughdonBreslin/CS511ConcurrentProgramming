int x=0;

def P = Thread.start {
    10.times {
        x++;
    }
}

def Q = Thread.start {
    10.times {
        x++;
    }
}
P.start(x)
Q.start(x)
println x;