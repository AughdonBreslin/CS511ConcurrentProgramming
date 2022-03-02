bool flag[2]
bool turn
byte critical = 0

active [2] proctype user ()
{
    flag[_pid] = true
    turn = _pid
    ( flag[1 - _pid] == false || turn == 1 - _pid)
crit : // critical section
    critical++;
    assert (critical == 1);
    critical--;
    flag[_pid] = false
}