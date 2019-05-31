// genesis

// CONSTANTS
// hippocampal cell resting potl and equilibr. potls
float EREST_ACT_PYR = -0.060	
float ENA_PYR = 0.105 + EREST_ACT_PYR		// 0.045
float EK_PYR = -0.025 + EREST_ACT_PYR		// -0.085

//This will not matter much...
float ECA_PYR = 0.140 + EREST_ACT_PYR		// 0.080

// soma area in square meters -- will be overwritten by readcell
float SOMA_A_PYR = 3.320e-9


/*---------------------------------------------------------------------------*/
// In {genesis_home}Scripts/neurokit/defaults.g
//Used to set the Z_A table of the K_AHP current
//Jose Manuel Ibarz, personal communication :-)))
function settab2const(gate, table, imin, imax, value)
    str gate, table
    int i, imin, imax
    float value
    for (i = (imin); i <= (imax); i = i + 1)
        setfield {gate} {table}->table[{i}] {value}
    end
end

/*--------------------------------------------------------------------------*/
//Compartments for the cell reader.
//From compartments.g
function make_cylind_compartment
        // These default compartment parameters will be overridden by readcell
	float RM = 0.33333      // specific membrane resistance (ohms m^2)
	float CM = 0.01         // specific membrane capacitance (farads/m^2)
	float RA = 0.3          // specific axial resistance (ohms m)
	float EREST_ACT = -0.07 // resting membrane potential (volts)
	float	len = 100.0e-6
	float	dia = 2.0e-6
	float PI = 3.14159
	float surface = len * dia * PI

	if (!{exists compartment})
		create	compartment compartment
	end
	setfield compartment \
		Cm		{CM * surface} \		// F
		Ra		{4.0*RA*len / (dia*dia*PI)} \	// ohm
		Em  	{EREST_ACT} \			// V
		Rm		{RM / surface} \ 		// ohm
                dia             {dia} \
		len		{len} \	
		inject		0.0
end

function make_cylind_symcompartment
        // These default compartment parameters can be overridden by readcell
	float RM = 0.33333      // specific membrane resistance (ohms m^2)
	float CM = 0.01         // specific membrane capacitance (farads/m^2)
	float RA = 0.3          // specific axial resistance (ohms m)
	float EREST_ACT = -0.07 // resting membrane potential (volts)
	float	len = 100.0e-6
	float	dia = 2.0e-6
	float PI = 3.14159
	float surface = len * dia * PI

	if (!{exists symcompartment})
		create	symcompartment symcompartment
	end
	setfield symcompartment \
		Cm		{CM * surface} \		// F
		Ra		{4.0*RA*len / (dia*dia*PI)} \	// ohm
		Em  	{EREST_ACT} \			// V
		Rm		{RM / surface} \ 		// ohm
                dia             {dia} \
		len		{len} \	
		inject		0.0
end


//Prototype channels for the CA1 pyramidal cell
/*------------------------------------------------------------------------*/
//The sodium (Na) channel
//I_Na = g_Na * m^3 * h * (Vm - E_Na)

function make_Na
	if (({exists Na}))
	        return
        end

        create tabchannel Na
        setfield ^ Ek {ENA_PYR} Gbar {300*SOMA_A_PYR} Ik 0 Gk 0 Xpower 3 \
             Ypower 1 Zpower 0

	float xmin = -0.1
        float xmax = 0.05
        int xdivs = 49

// m
	call Na TABCREATE X {xdivs} {xmin} {xmax}

        int i
        float x, dx, y, z
        dx = (xmax - xmin)/xdivs
        x = xmin
        for (i = 0; i <= (xdivs); i = i + 1)
		y = -3.48e6 * {x - 0.011} / {{exp {(x-0.011) / -0.01294}} - 1}
		z = 0.12e6 * {x - 0.0059} / {{exp {(x-0.0059) / 0.00447}} - 1}
	        setfield Na X_A->table[{i}] {y}
        	setfield Na X_B->table[{i}] {y+z}
		x = x + dx
        end

        setfield Na X_A->calc_mode 0 X_B->calc_mode 0
        call Na TABFILL X 3000 0

// h
	setupalpha Na Y 3e3 0.0 0.0 80e-3 10e-3 \
		12e3 0.0 1.0 -77e-3 -27e-3
end


/*------------------------------------------------------------------------*/
//The delayed rectifier potassium (K_DR) channel
//I_DR = g_DR * n^4 * (Vm - E_K)

function make_K_DR
        if (({exists K_DR}))
                return
        end

        create tabchannel K_DR
        setfield ^ Ek {EK_PYR} Gbar {150*SOMA_A_PYR} Ik 0 Gk 0 Xpower 4  \
             Ypower 0 Zpower 0

/* Cannot do this because of the singularity	
	setupalpha K_DR X 0.0 -0.018e6 -1.0 0.0 -25e-3 \
		-3.6e4 3.6e3 -1.0 -10e-3 12e-3
*/
	float xmin = -0.1
        float xmax = 0.05
        int xdivs = 49

// n
	call K_DR TABCREATE X {xdivs} {xmin} {xmax}

        int i
        float x, dx, y, z
        dx = (xmax - xmin)/xdivs
        x = xmin
        for (i = 0; i <= (xdivs); i = i + 1)
		y = {-18e3 * x} / {{exp {x/ -25e-3}} - 1}
		z = 3.6e3 * {x - 10e-3} / {{exp {(x-10e-3) / 12e-3}} - 1}
	        setfield K_DR X_A->table[{i}] {y}
        	setfield K_DR X_B->table[{i}] {y+z}
		x = x + dx
        end

        setfield K_DR X_A->calc_mode 0 X_B->calc_mode 0
        call K_DR TABFILL X 3000 0
end


/*------------------------------------------------------------------------*/
//The muscarinic potassium (K_M) channel
// I_M = g_M * u^2 * (Vm - EK_PYR)

function make_K_M
        if (({exists K_M}))
                return
        end

        create tabchannel K_M
        setfield ^ Ek {EK_PYR} Gbar {150*SOMA_A_PYR} Ik 0 Gk 0 Xpower 2  \
             Ypower 0 Zpower 0
// u
	setupalpha K_M X 16 0.0 0.0 52.7e-3 -23e-3 \
		16 0.0 0.0 52.7e-3 18.8e-3
end


/*------------------------------------------------------------------------*/
//The A-type transient potassium (K_A) channel
// I_A = g_A * a * b * (Vm - E_K)

function make_K_A
        if (({exists K_A}))
                return
        end

	create tabchannel K_A
	setfield ^ Ek {EK_PYR} Gbar {150*SOMA_A_PYR} Ik 0 Gk 0 Xpower 1 \
		Ypower 1 Zpower 0

	float xmin = -0.1
        float xmax = 0.05
        int xdivs = 49

// a
	call K_A TABCREATE X {xdivs} {xmin} {xmax}

        int i
        float x, dx, alpha, beta
        dx = (xmax - xmin)/xdivs
        x = xmin
        for (i = 0; i <= (xdivs); i = i + 1)
		alpha = -50e3 * {x + 20e-3} / \
			{{exp {(x + 20e-3) / -15e-3}} - 1}
		beta = 0.1e6 * {x + 10e-3} / {{exp {(x + 10e-3) / 8e-3}} - 1}
	        setfield K_A X_A->table[{i}] {alpha}
        	setfield K_A X_B->table[{i}] {alpha+beta}
		x = x + dx
        end

        setfield K_A X_A->calc_mode 0 X_B->calc_mode 0
        call K_A TABFILL X 3000 0
	
// b
	setupalpha K_A Y 0.15 0.0 0.0 18e-3 15e-3 \
		60 0.0 1.0 73e-3 -12e-3
end


/*------------------------------------------------------------------------*/
//The calcium current
// I_Ca = g_Ca * s^2 * r * (Vm-E_Ca)

function make_Ca
        if (({exists Ca}))
                return
        end

        create tabchannel Ca
        setfield ^ Ek {ECA_PYR} Gbar {40*SOMA_A_PYR} Ik 0 Gk 0 Xpower 2  \
               Ypower 1 Zpower 0

// s
	
	float xmin = -0.1
        float xmax = 0.05
        int xdivs = 49

	call Ca TABCREATE X {xdivs} {xmin} {xmax}
// For testing
float add=0
float mult=0.3

        int i
        float x, dx, alpha, beta
        dx = (xmax - xmin)/xdivs
        x = xmin
        for (i = 0; i <= (xdivs); i = i + 1)
		alpha = 0.1 * -0.16e6 * {x + 26e-3 + add} / {{exp {(x + 26e-3 + add) / -4.5e-3}} - 1}
		beta  = 0.1 * 0.04e6 * {x + 12e-3 + add} / {{exp {(x + 12e-3 + add) / 10e-3}} - 1}
	        setfield Ca X_A->table[{i}] {alpha}
        	setfield Ca X_B->table[{i}] {alpha+beta}
		x = x + dx
        end

        setfield Ca X_A->calc_mode 0 X_B->calc_mode 0
        call Ca TABFILL X 3000 0

// r
	setupalpha Ca Y {mult*2e3} 0.0 0.0 {94e-3 + add} 10e-3 \
		{mult*8e3} 0.0 1.0 {-68e-3 + add} -27e-3
end


/*------------------------------------------------------------------------*/
//A table to calculate equilibrium potential of the Ca ion
//E_Ca= -0.0133*log((Ca)/1.2)

function make_ECa_comp
	if (({exists ECa_comp}))
		return
	end
	create table ECa_comp

	float xmin = 0.00005
        float xmax = 0.01
        int xdivs = 100

	call ECa_comp TABCREATE {xdivs} {xmin} {xmax}

        int i
        float x, dx, eca
        dx = (xmax - xmin)/xdivs
        x = xmin
        for (i = 0; i <= (xdivs); i = i + 1)
		eca = {-0.0133 * {log {x/1.2 }} }
		setfield ECa_comp table->table[{i}] {eca}
		x = x + dx
        end

        setfield ECa_comp table->calc_mode 0
        call ECa_comp TABFILL 3000 0
end


/*----------------------------------------------------------------------*/
//This function copies the above object into every bits of the cell
//and establishes connections.
function setup_ECa_comp
	if ((!{exists /library/ECa_comp}))
		echo /library/ECa_comp can not be found. Terminating.
		return
	end

	str part
	foreach part ({el /prot_pyr/#})
		if (!{exists {part}/Ca_concI} || !{exists {part}/Ca})
			echo The calcium pool or calcium current is missing. Terminating.
		end
		copy /library/ECa_comp {part}
		addmsg {part}/Ca_concI {part}/ECa_comp INPUT Ca
		addmsg {part}/ECa_comp {part}/Ca EK output
	end
end


/*------------------------------------------------------------------------*/
//FIRST calcium concentration for E_Ca and K_C
//d[Ca]/dt = [Ca]/tau - f/(w * z * F * A) * I_Ca
//where tau = 9e-4 sec, w = 1e-6 m, z = 2 (valence of Ca++),
//F = 96484.6 C/mol, A is the compartment area
//f = 0.7
//From Jose Manuel Ibarz

function make_Ca_concI
        if (({exists Ca_concI}))
                return
        end
        create Ca_concen Ca_concI
        setfield ^ tau 0.0009 B 3e-6 Ca_base 0.00005 thick 1e-6
        if (!{exists Ca_concI sendmsg1})
            addfield Ca_concI sendmsg1
        end
        setfield  Ca_concI sendmsg1 "../Ca . I_Ca Ik"
end


/*------------------------------------------------------------------------*/
//SECOUND calcium concentration for K_AHP
//d[Ca]/dt = [Ca]/tau - f/(w * z * F * A) * I_Ca
//where tau = 1 sec, w = 1e-6 m, z = 2 (valence of Ca++),
//F = 96484.6 C/mol, A is the compartment area
//f = 0.024
//There are rumors about tau being 2 sec
//From Jose Manuel Ibarz

function make_Ca_concII
        if (({exists Ca_concII}))
                return
        end
        create Ca_concen Ca_concII
        setfield ^ tau 1 B 3e-6 Ca_base 0.00005 thick 1e-6
        if (!{exists Ca_concII sendmsg1})
            addfield Ca_concII sendmsg1
        end
        setfield  Ca_concII sendmsg1 "../Ca . I_Ca Ik"
end


/*------------------------------------------------------------------------*/
//The K_AHP current
//I_AHP = g_AHP * q * (Vm - E_K)
//From Jose Manuel Ibarz

function make_K_AHP
	if (({exists K_AHP}))
		return
	end

	create tabchannel K_AHP
	setfield ^ Ek {EK_PYR} Gbar {SOMA_A_PYR} Ik 0 Gk 0 Xpower 0  \
  		Ypower 0 Zpower 1
//q
	call K_AHP TABCREATE Z 30 0 0.003

	settab2const K_AHP Z_A 0 30 0.048            // sets tau = 48 ms

	setfield K_AHP Z_B->table[0] 0 \
	Z_B->table[1] 0.0044  Z_B->table[2] 0.0353  \
	Z_B->table[3] 0.111  Z_B->table[4] 0.231 \
	Z_B->table[5] 0.372  Z_B->table[6] 0.508 \
	Z_B->table[7] 0.622  Z_B->table[8] 0.712 \
	Z_B->table[9] 0.780  Z_B->table[10] 0.830 \
	Z_B->table[11] 0.867  Z_B->table[12] 0.895  \
	Z_B->table[13] 0.915  Z_B->table[14] 0.931 \
	Z_B->table[15] 0.944  Z_B->table[16] 0.953 \
	Z_B->table[17] 0.961  Z_B->table[18] 0.967 \
	Z_B->table[19] 0.972  Z_B->table[20] 0.976 \
	Z_B->table[21] 0.979  Z_B->table[22] 0.982 \
	Z_B->table[23] 0.984  Z_B->table[24] 0.986 \
	Z_B->table[25] 0.987  Z_B->table[26] 0.989 \
	Z_B->table[27] 0.990  Z_B->table[28] 0.991 \
	Z_B->table[29] 0.992  Z_B->table[30] 1.000

	tweaktau K_AHP Z
	setfield K_AHP Z_A->calc_mode 0 Z_B->calc_mode 0
	call K_AHP TABFILL Z 3000 0

	if (!{exists K_AHP addmsg1})
		addfield K_AHP addmsg1
	end

	setfield  K_AHP addmsg1 "../Ca_concII . CONCEN Ca"
end

/*------------------------------------------------------------------*/
//The CT type potassium current
//I_CT = g_CT * c * d * (V_m - E_K)


function make_K_C
	if (({exists K_C}))
		return
	end

	create tab2Dchannel K_C
	setfield ^ Ek {EK_PYR} Gbar 0.0 \
		Xindex {VOLT_C1_INDEX} Xpower 2 \
		Yindex {VOLT_INDEX} Ypower 1 \
		Zpower 0

	int xdivs = 100
	int ydivs = {xdivs}
	float y, dy, x, dx, a, b, vshift
	float xmin, xmax, ymin, ymax
	int i, j

	xmin = -0.1; xmax = 0.05; ymin = 0.00005; ymax = 0.0030
	dx = (xmax - xmin)/xdivs
	dy = (ymax - ymin)/ydivs
	x = xmin

//c
	call K_C TABCREATE X {xdivs} {xmin} {xmax} \
		{ydivs} {ymin} {ymax}
	for (i = 0; i <= xdivs; i = i + 1)
		y = ymin
		for (j = 0; j <= ydivs; j = j + 1)
			vshift = 40e-3 * {log {y/13.805e-3}}
			a = -7.7e3 * (x + vshift + 0.103) / \
              ({exp {(x + vshift + 0.103) / (-12e-3)}} -1)
			setfield K_C X_A->table[{i}][{j}] {a}
			setfield K_C X_B->table[{i}][{j}] 909.09 // tau_c = 1.1ms
			y = y + dy
		end
		x = x + dx
	end

//d

	xdivs = 3000
	call K_C TABCREATE Y 0 0 0 \
		{xdivs} {xmin} {xmax}

        dx = (xmax - xmin)/xdivs
        x = xmin
        for (i = 0; i <= (xdivs); i = i + 1)
		a = 1e3 / {exp {(x + 79e-3) / 10e-3} }
		b = 4e3 / ({exp {(x - 82e-3) / (-27e-3)}} + 1)
		setfield K_C Y_A->table[0][{i}] {a}
		setfield K_C Y_B->table[0][{i}] {a + b}
		x = x + dx
        end

        setfield K_C Y_A->calc_mode 0 Y_B->calc_mode 0

	if (!{exists K_C addmsg1})
		addfield K_C addmsg1
	end

	setfield  K_C addmsg1 "../Ca_concI . CONCEN1 Ca"
end

/*---------------------------------------------------------------------------*/
//The hyperpolarization-activated currents
//From:
//Jeffrey C. Magee: Dendritic Hyperpolarization-Activated Currents Modify the
//Integrative Properties of Hippocampal CA1 Pyramidal Neurons. Journal of
//Neuroscience 18: 7613-7624, 1998
//SOMATIC VARIANT

function make_I_H_S
	if (({exists I_H_S}))
		return
	end

	create tabchannel I_H_S
	setfield ^ Ek 0.0 Gbar 1.0 Ik 0 Gk 0 Xpower 1 
//h
	call I_H_S TABCREATE X 12 -0.14 -0.02

	setfield I_H_S \
    X_A->table[0] 0.017 \
    X_A->table[1] 0.017       X_A->table[2] 0.020 \
    X_A->table[3] 0.024       X_A->table[4] 0.030 \
    X_A->table[5] 0.039       X_A->table[6] 0.047 \
    X_A->table[7] 0.040       X_A->table[8] 0.020 \
    X_A->table[9] 0.016       X_A->table[10] 0.011 \
    X_A->table[11] 0.008 \
    X_A->table[12] 0.008

    setfield I_H_S \
    X_B->table[0] 1.0 \
    X_B->table[1] 1.0        X_B->table[2] 0.98 \
    X_B->table[3] 0.96       X_B->table[4] 0.90 \
    X_B->table[5] 0.72       X_B->table[6] 0.40 \
    X_B->table[7] 0.15       X_B->table[8] 0.063 \
    X_B->table[9] 0.04       X_B->table[10] 0.0 \
    X_B->table[11] 0.0 \
    X_B->table[12] 0.0



	tweaktau I_H_S X
	setfield I_H_S X_A->calc_mode 0 X_B->calc_mode 0
	call I_H_S TABFILL X 3000 0
end

//DENDRITIC VARIANT

function make_I_H_D
	if (({exists I_H_D}))
		return
	end

	create tabchannel I_H_D
	setfield ^ Ek 0.0 Gbar 1.0 Ik 0 Gk 0 Xpower 1 
//h
	call I_H_D TABCREATE X 12 -0.14 -0.02

//For testing
    float mult=1

	setfield I_H_D \
    X_A->table[0] {0.017 * mult}\
    X_A->table[1] {0.017 * mult}      X_A->table[2] {0.020  * mult}\
    X_A->table[3] {0.024 * mult}       X_A->table[4] {0.030  * mult}\
    X_A->table[5] {0.039 * mult}       X_A->table[6] {0.047  * mult}\
    X_A->table[7] {0.040 * mult}       X_A->table[8] {0.020  * mult}\
    X_A->table[9] {0.016 * mult}       X_A->table[10] {0.011  * mult}\
    X_A->table[11] {0.008 * mult} \
    X_A->table[12] {0.008 * mult}

    setfield I_H_D \
    X_B->table[0] 1.0 \
    X_B->table[1] 1.0        X_B->table[2] 0.96 \
    X_B->table[3] 0.68       X_B->table[4] 0.40 \
    X_B->table[5] 0.16       X_B->table[6] 0.063 \
    X_B->table[7] 0.04       X_B->table[8] 0.0 \
    X_B->table[9] 0.00       X_B->table[10] 0.0 \
    X_B->table[11] 0.0 \
    X_B->table[12] 0.0



	tweaktau I_H_D X
	setfield I_H_D X_A->calc_mode 0 X_B->calc_mode 0
	call I_H_D TABFILL X 3000 0
end

