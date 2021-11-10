int x=0;

Thread.start {
    10.times {
        x++;
    }
}

Thread.start {
    10.times {
        x++;
    }
}

println x;
