#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC :init: */
	case 3: // STATE 1 - pet3.pml:39 - [(run P())] (0:0:0 - 1)
		IfNotBlocked
		reached[2][1] = 1;
		if (!(addproc(II, 1, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 2 - pet3.pml:40 - [(run Q())] (0:0:0 - 1)
		IfNotBlocked
		reached[2][2] = 1;
		if (!(addproc(II, 1, 1)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 4 - pet3.pml:42 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[2][4] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Q */
	case 6: // STATE 1 - pet3.pml:24 - [last = 2] (0:0:1 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		(trpt+1)->bup.oval = ((int)now.last);
		now.last = 2;
#ifdef VAR_RANGES
		logval("last", ((int)now.last));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 2 - pet3.pml:25 - [wantQ = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		(trpt+1)->bup.oval = ((int)now.wantQ);
		now.wantQ = 1;
#ifdef VAR_RANGES
		logval("wantQ", ((int)now.wantQ));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 3 - pet3.pml:27 - [(((wantP==0)||(last==1)))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][3] = 1;
		if (!(((((int)now.wantP)==0)||(((int)now.last)==1))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 9 - pet3.pml:30 - [critical = (critical+1)] (0:0:1 - 3)
		IfNotBlocked
		reached[1][9] = 1;
		(trpt+1)->bup.oval = ((int)now.critical);
		now.critical = (((int)now.critical)+1);
#ifdef VAR_RANGES
		logval("critical", ((int)now.critical));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 10 - pet3.pml:31 - [assert((critical==1))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][10] = 1;
		spin_assert((((int)now.critical)==1), "(critical==1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 11 - pet3.pml:32 - [critical = (critical-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[1][11] = 1;
		(trpt+1)->bup.oval = ((int)now.critical);
		now.critical = (((int)now.critical)-1);
#ifdef VAR_RANGES
		logval("critical", ((int)now.critical));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 12 - pet3.pml:33 - [wantQ = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][12] = 1;
		(trpt+1)->bup.oval = ((int)now.wantQ);
		now.wantQ = 0;
#ifdef VAR_RANGES
		logval("wantQ", ((int)now.wantQ));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 16 - pet3.pml:35 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][16] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC P */
	case 14: // STATE 1 - pet3.pml:9 - [last = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		(trpt+1)->bup.oval = ((int)now.last);
		now.last = 1;
#ifdef VAR_RANGES
		logval("last", ((int)now.last));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 15: // STATE 2 - pet3.pml:10 - [wantP = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		(trpt+1)->bup.oval = ((int)now.wantP);
		now.wantP = 1;
#ifdef VAR_RANGES
		logval("wantP", ((int)now.wantP));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 3 - pet3.pml:12 - [(((wantQ==0)||(last==2)))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		if (!(((((int)now.wantQ)==0)||(((int)now.last)==2))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 9 - pet3.pml:15 - [critical = (critical+1)] (0:0:1 - 3)
		IfNotBlocked
		reached[0][9] = 1;
		(trpt+1)->bup.oval = ((int)now.critical);
		now.critical = (((int)now.critical)+1);
#ifdef VAR_RANGES
		logval("critical", ((int)now.critical));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 18: // STATE 10 - pet3.pml:16 - [assert((critical==1))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][10] = 1;
		spin_assert((((int)now.critical)==1), "(critical==1)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 19: // STATE 11 - pet3.pml:17 - [critical = (critical-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][11] = 1;
		(trpt+1)->bup.oval = ((int)now.critical);
		now.critical = (((int)now.critical)-1);
#ifdef VAR_RANGES
		logval("critical", ((int)now.critical));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 20: // STATE 12 - pet3.pml:18 - [wantP = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][12] = 1;
		(trpt+1)->bup.oval = ((int)now.wantP);
		now.wantP = 0;
#ifdef VAR_RANGES
		logval("wantP", ((int)now.wantP));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 21: // STATE 16 - pet3.pml:20 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][16] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

