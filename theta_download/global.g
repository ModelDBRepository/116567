//genesis

/*****This script sets global parameters
******/

int	i					//generally used for cycles
float	seed					//randomizing kernel
seed = {randseed}

//***** Integration time (at least for interneurons)
float	dt = 1e-5
setclock 0 {dt}

//*****Data collection time
float	dt2 = 5e-4
setclock 1 {dt2}

str	gp, pp, sp

//*****Size of cell populations
int	N_olm	=	1
int	N_b	    =	100
int	N_msg	=	1
int N_pyr   =   1
int N_ax    =   1

gp = "/home/bognor/data/"
pp = "pyr2olm/"
sp = ""

