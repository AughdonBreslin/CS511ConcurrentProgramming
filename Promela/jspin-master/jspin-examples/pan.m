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

		 /* CLAIM p2 */
	case 3: // STATE 1 - _spin_nvr.tmp:21 - [(!((!(((gate==0)&&(((test[0]==0)&&(test[1]==0))&&(test[2]==0))))||(count==0))))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[3][1] = 1;
		if (!( !(( !(((((int)now.gate)==0)&&(((((int)now.test[0])==0)&&(((int)now.test[1])==0))&&(((int)now.test[2])==0))))||(now.count==0)))))
			continue;
		/* merge: assert(!(!((!(((gate==0)&&(((test[0]==0)&&(test[1]==0))&&(test[2]==0))))||(count==0)))))(0, 2, 6) */
		reached[3][2] = 1;
		spin_assert( !( !(( !(((((int)now.gate)==0)&&(((((int)now.test[0])==0)&&(((int)now.test[1])==0))&&(((int)now.test[2])==0))))||(now.count==0)))), " !( !(( !(((gate==0)&&(((test[0]==0)&&(test[1]==0))&&(test[2]==0))))||(count==0))))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[3][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 4: // STATE 10 - _spin_nvr.tmp:26 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[3][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM p1 */
	case 5: // STATE 1 - _spin_nvr.tmp:12 - [(!((!((count==0))||(gate==0))))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[2][1] = 1;
		if (!( !(( !((now.count==0))||(((int)now.gate)==0)))))
			continue;
		/* merge: assert(!(!((!((count==0))||(gate==0)))))(0, 2, 6) */
		reached[2][2] = 1;
		spin_assert( !( !(( !((now.count==0))||(((int)now.gate)==0)))), " !( !(( !((count==0))||(gate==0))))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[2][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 6: // STATE 10 - _spin_nvr.tmp:17 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[2][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* CLAIM p0 */
	case 7: // STATE 1 - _spin_nvr.tmp:3 - [(!((gate<=1)))] (6:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported1 = 0;
			if (verbose && !reported1)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported1 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[1][1] = 1;
		if (!( !((((int)now.gate)<=1))))
			continue;
		/* merge: assert(!(!((gate<=1))))(0, 2, 6) */
		reached[1][2] = 1;
		spin_assert( !( !((((int)now.gate)<=1))), " !( !((gate<=1)))", II, tt, t);
		/* merge: .(goto)(0, 7, 6) */
		reached[1][7] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 8: // STATE 10 - _spin_nvr.tmp:8 - [-end-] (0:0:0 - 1)
		
#if defined(VERI) && !defined(NP)
#if NCLAIMS>1
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	int nn = (int) ((Pclaim *)pptr(0))->_n;
				printf("depth %ld: Claim %s (%d), state %d (line %d)\n",
					depth, procname[spin_c_typ[nn]], nn, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#else
		{	static int reported10 = 0;
			if (verbose && !reported10)
			{	printf("depth %d: Claim, state %d (line %d)\n",
					(int) depth, (int) ((Pclaim *)pptr(0))->_p, src_claim[ (int) ((Pclaim *)pptr(0))->_p ]);
				reported10 = 1;
				fflush(stdout);
		}	}
#endif
#endif
		reached[1][10] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC P */
	case 9: // STATE 1 - barz.pml:27 - [((gate>0))] (5:0:2 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		if (!((((int)now.gate)>0)))
			continue;
		/* merge: gate = (gate-1)(5, 2, 5) */
		reached[0][2] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.gate);
		now.gate = (((int)now.gate)-1);
#ifdef VAR_RANGES
		logval("gate", ((int)now.gate));
#endif
		;
		/* merge: test[_pid] = 1(5, 3, 5) */
		reached[0][3] = 1;
		(trpt+1)->bup.ovals[1] = ((int)now.test[ Index(((int)((P0 *)_this)->_pid), 3) ]);
		now.test[ Index(((P0 *)_this)->_pid, 3) ] = 1;
#ifdef VAR_RANGES
		logval("test[_pid]", ((int)now.test[ Index(((int)((P0 *)_this)->_pid), 3) ]));
#endif
		;
		_m = 3; goto P999; /* 2 */
	case 10: // STATE 5 - barz.pml:28 - [assert((gate==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][5] = 1;
		spin_assert((((int)now.gate)==0), "(gate==0)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 13 - barz.pml:29 - [D_STEP29]
		IfNotBlocked

		reached[0][13] = 1;
		reached[0][t->st] = 1;
		reached[0][tt] = 1;

		if (TstOnly) return 1;

		sv_save();
		S_005_0: /* 2 */
		now.count = (now.count-1);
#ifdef VAR_RANGES
		logval("count", now.count);
#endif
		;
S_009_0: /* 2 */
S_006_0: /* 2 */
		if (!((now.count>0)))
			goto S_009_1;
S_007_0: /* 2 */
		now.gate = (((int)now.gate)+1);
#ifdef VAR_RANGES
		logval("gate", ((int)now.gate));
#endif
		;
		goto S_010_0;
S_009_1: /* 3 */
S_008_0: /* 2 */
		/* else */;
		goto S_010_0;
S_009_2: /* 3 */
		Uerror("blocking sel in d_step (nr.0, near line 31)");
S_010_0: /* 2 */
S_011_0: /* 2 */
		now.test[ Index(((P0 *)_this)->_pid, 3) ] = 0;
#ifdef VAR_RANGES
		logval("test[_pid]", ((int)now.test[ Index(((int)((P0 *)_this)->_pid), 3) ]));
#endif
		;
		goto S_017_0;
S_017_0: /* 1 */

#if defined(C_States) && (HAS_TRACK==1)
		c_update((uchar *) &(now.c_state[0]));
#endif
		_m = 3; goto P999;

	case 12: // STATE 14 - critical.h:18 - [printf('MSC: %d in CS\\n',_pid)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][14] = 1;
		Printf("MSC: %d in CS\n", ((int)((P0 *)_this)->_pid));
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 15 - critical.h:23 - [critical = (critical+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][15] = 1;
		(trpt+1)->bup.oval = ((int)now.critical);
		now.critical = (((int)now.critical)+1);
#ifdef VAR_RANGES
		logval("critical", ((int)now.critical));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 16 - critical.h:25 - [assert((critical<=2))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][16] = 1;
		spin_assert((((int)now.critical)<=2), "(critical<=2)", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 15: // STATE 17 - critical.h:26 - [critical = (critical-1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][17] = 1;
		(trpt+1)->bup.oval = ((int)now.critical);
		now.critical = (((int)now.critical)-1);
#ifdef VAR_RANGES
		logval("critical", ((int)now.critical));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 16: // STATE 25 - barz.pml:41 - [D_STEP41]
		IfNotBlocked

		reached[0][25] = 1;
		reached[0][t->st] = 1;
		reached[0][tt] = 1;

		if (TstOnly) return 1;

		sv_save();
		S_018_0: /* 2 */
		now.count = (now.count+1);
#ifdef VAR_RANGES
		logval("count", now.count);
#endif
		;
S_022_0: /* 2 */
S_019_0: /* 2 */
		if (!((now.count==1)))
			goto S_022_1;
S_020_0: /* 2 */
		now.gate = (((int)now.gate)+1);
#ifdef VAR_RANGES
		logval("gate", ((int)now.gate));
#endif
		;
		goto S_023_0;
S_022_1: /* 3 */
S_021_0: /* 2 */
		/* else */;
		goto S_023_0;
S_022_2: /* 3 */
		Uerror("blocking sel in d_step (nr.1, near line 43)");
S_023_0: /* 2 */
		goto S_026_0;
S_026_0: /* 1 */

#if defined(C_States) && (HAS_TRACK==1)
		c_update((uchar *) &(now.c_state[0]));
#endif
		_m = 3; goto P999;

	case 17: // STATE 29 - barz.pml:49 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][29] = 1;
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

