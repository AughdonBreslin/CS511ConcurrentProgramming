#define N	4
#define L	10

byte nr_leaders;

// ltl p1 { <>(nr_leaders>0) };
// ltl p2 { <>[](nr_leaders==1) };
ltl p3 { [](nr_leaders==0 || nr_leaders==1) };

/** Some node is eventually elected as leader
    Eventually, it will always be true that there is exactly one leader
    It is always the case that there are either 0 or 1 leaders chosen*/
mtype = { one, winner };
chan q[N] = [L] of {mtype, byte};

proctype nnode (chan inp, out; byte mynumber)
{
  //nr = number received
  byte nr, neighbor;

  xr inp; /* channel assertion: exclusive recv access to channel in */
  xs out; /* channel assertion: exclusive send access to channel out */
  
  printf("NNode: %d\n", mynumber);
  
  out ! one(mynumber);
  
  end: do
      // electing leader
      :: inp ? one(nr) ->
         /* complete here */
         if
          :: nr == mynumber -> out!winner(nr); /* process is the leader, start round2 */
                               nr_leaders++ 
          :: nr > mynumber -> out!one(nr);     /* forward identifier to next node */
          :: nr < mynumber -> skip;            /* purge message */
         fi;
         mynumber;
      // notifying 
      :: inp ? winner(nr) -> 
         /* complete here */
         if
          :: nr != mynumber -> out!winner(mynumber); /* keep forwarding until winner gets own message */
          :: else -> skip;
         fi
         
	 break;
  od
  do /* dummy loop to ensure non-termination */
    :: true -> skip
  od
}

init {
  byte Ini[6];
  byte I;
  
  for (I : 1 .. N) {
     if
       :: Ini[0] == 0 && N >= 1 -> Ini[0] = I 
       :: Ini[1] == 0 && N >= 2 -> Ini[1] = I 
       :: Ini[2] == 0 && N >= 3 -> Ini[2] = I 
       :: Ini[3] == 0 && N >= 4 -> Ini[3] = I 
       :: Ini[4] == 0 && N >= 5 -> Ini[4] = I 
       :: Ini[5] == 0 && N >= 6 -> Ini[5] = I 
    fi;
  }		
  atomic {
    int proc;
    for (proc : 1 .. N ) {
       run nnode (q[proc-1],q[proc%N], Ini[proc-1]);
       printf("Initializing %d %d %d \n", q[proc-1],q[proc%N], Ini[proc-1])
    }
  }
	
}
