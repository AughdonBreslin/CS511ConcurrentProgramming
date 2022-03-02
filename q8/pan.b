	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC :init: */

	case 3: // STATE 1
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 4: // STATE 2
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 5: // STATE 4
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC Q */

	case 6: // STATE 1
		;
		now.last = trpt->bup.oval;
		;
		goto R999;

	case 7: // STATE 2
		;
		now.wantQ = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 9: // STATE 9
		;
		now.critical = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 11: // STATE 11
		;
		now.critical = trpt->bup.oval;
		;
		goto R999;

	case 12: // STATE 12
		;
		now.wantQ = trpt->bup.oval;
		;
		goto R999;

	case 13: // STATE 16
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC P */

	case 14: // STATE 1
		;
		now.last = trpt->bup.oval;
		;
		goto R999;

	case 15: // STATE 2
		;
		now.wantP = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 17: // STATE 9
		;
		now.critical = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 19: // STATE 11
		;
		now.critical = trpt->bup.oval;
		;
		goto R999;

	case 20: // STATE 12
		;
		now.wantP = trpt->bup.oval;
		;
		goto R999;

	case 21: // STATE 16
		;
		p_restor(II);
		;
		;
		goto R999;
	}

