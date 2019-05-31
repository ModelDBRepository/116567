//genesis

//*****************************************************************************
//... es lon a kornek kerulete
float	PI		=	3.14159

//*****************************************************************************
//integralasi idok adjusztalasa

//*****************************************************************************
//Az egyszeruseg es elegancia kedveert:
int	EXPONENTIAL	=	1
int	SIGMOID		=	2
int	LINOID		=	3

//*****************************************************************************
///Remelheto, hogy ekkora egy sejt ...
float	SOMA_D_AXAX	=	20.0e-6				// m
float	SOMA_L_AXAX	=	20.0e-6				// m
float	SOMA_A_AXAX	=	PI * SOMA_D_AXAX * SOMA_L_AXAX	// m^2
float	SOMA_XA_AXAX	=	PI * SOMA_D_AXAX * SOMA_D_AXAX / 4	// m^2

//*****************************************************************************
//Tovabbi szukseges konstansok
//MEMBRANE PARAMETERS
float	RM_AXAX		=	1		// ohm*m^2
float	RA_AXAX		=	0.3		// ohm-m
float	CM_AXAX		=	0.01		// F/m^2
float	EREST_ACT_AXAX	=	-65e-3		// V

//*****************************************************************************
//A tablazatokhoz

float	VRES		=	3200
float	VMIN		=	-0.100		// V
float	VMAX		=	0.110		// V

//*****************************************************************************
//A misztikus PHI parameter
float	Phi		=	5

//Szinapszis kuszob fesz.
float Theta_o2a = 0

