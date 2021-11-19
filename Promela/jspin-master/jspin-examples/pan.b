	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* CLAIM p2 */
;
		
	case 3: // STATE 1
		goto R999;

	case 4: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM p1 */
;
		
	case 5: // STATE 1
		goto R999;

	case 6: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* CLAIM p0 */
;
		
	case 7: // STATE 1
		goto R999;

	case 8: // STATE 10
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC P */

	case 9: // STATE 3
		;
		now.test[ Index(((P0 *)_this)->_pid, 3) ] = trpt->bup.ovals[1];
		now.gate = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
			case 11: // STATE 13
		sv_restor();
		goto R999;
;
		;
		
	case 13: // STATE 15
		;
		now.critical = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 15: // STATE 17
		;
		now.critical = trpt->bup.oval;
		;
		goto R999;
	case 16: // STATE 25
		sv_restor();
		goto R999;

	case 17: // STATE 29
		;
		p_restor(II);
		;
		;
		goto R999;
	}

