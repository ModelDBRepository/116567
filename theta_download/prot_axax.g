// genesis
include kons_axax.g

/****!!!!!This version does not contain any specific properties of axo-axonic cells!!!!! and is not currently maintained****/

/*****This script creates a prototype for the axo-axonic interenuron which 
******selectively terminates on the axon-initial segment of pyramidal cells 
******controlling action potential generation of these cells
******/

create neutral /prot_axax

//*****************************************************************************
//*****Somatic compartment
create	compartment 	/prot_axax/soma
setfield 		/prot_axax/soma \
	Cm		{CM_AXAX * SOMA_A_AXAX} \			// F
	Ra		{RA_AXAX * SOMA_L_AXAX /SOMA_XA_AXAX}\ // ohm (felesleges)
	Em  		{EREST_ACT_AXAX} \				// V
	Rm		{RM_AXAX/SOMA_A_AXAX} \  			// ohm
	inject		{1.4 * {SOMA_A_AXAX} * 1e-2} \
	initVm		-0.065

//*****************************************************************************
//*****Active sodium channel a la Wang & Buzsaki '96 with fast m gate
create	vdep_channel	/prot_axax/soma/Na_channel
setfield 	/prot_axax/soma/Na_channel \
	Ek 		55e-3 \					// V
	gbar		{ 350 * {SOMA_A_AXAX} }			// S

//*****the m gate of the sodium channel
create table /prot_axax/soma/Na_channel/m_gate

ce /prot_axax/soma/Na_channel/m_gate

call . TABCREATE {VRES} {VMIN} {VMAX}
int i
float y
float alpham
float betam
float x
for (i = 0; i<= VRES; i = i + 1)
   x = (i * (VMAX - VMIN) / VRES) + VMIN
   alpham= -0.1e+6 * ( x  + 0.035) / ({ exp {-0.1e+3 * ( x + 0.035 )} } - 1)
   betam= 4e+3 * { exp { -1 * ( x + 0.060 ) / 0.018 } }
   y = alpham / ( alpham + betam )
   if (x == -0.035)
      y = 0.9970947
   end 
   setfield . table->table[{i}] {y}
end
setfield . table->calc_mode 0

ce /

//*****the h gate of the sodium channel
create tabgate /prot_axax/soma/Na_channel/h_gate

/*****tobb dolog is megkavarja a nagysagrandeket es elojeleket: atteres mV->V;
******atteres ms->s; az exponencialis szamlaloban, vagy nevezoben van-e
******/

setupgate ^ alpha {Phi*70} 0 0 58e-3 20e-3 -size {VRES} -range {VMIN} {VMAX}
setupgate ^ beta {Phi*1e+3} 0 1 28e-3 -10e-3 -size {VRES} -range {VMIN} {VMAX}

//*****Connecting gates to the channel
ce /prot_axax/soma/Na_channel
addmsg m_gate . MULTGATE output 3
addmsg h_gate . MULTGATE m 1
ce /

//*****************************************************************************
//*****Active potassium channel (deleyed rectifier)

create vdep_channel /prot_axax/soma/K_channel
setfield ^  Ek -90e-3 gbar {90*{SOMA_A_AXAX}}

create tabgate /prot_axax/soma/K_channel/nv_gate

setupgate ^ alpha {-0.01e+6*Phi*0.034} {-0.01e+6*Phi} -1 0.034 -10e-3 -size {VRES} -range {VMIN} {VMAX}
setupgate ^ beta {0.125e+3*Phi} 0 0 0.044 0.080 -size {VRES} -range {VMIN} {VMAX}


//*****Connecting gates to the channel
ce /prot_axax/soma/K_channel
addmsg nv_gate . MULTGATE m 4
ce /

//*****************************************************************************
//*****Copying constituents to a prototype cell

ce /prot_axax/soma

addmsg . 		K_channel/nv_gate 	VOLTAGE	Vm
addmsg K_channel	. 			CHANNEL Gk Ek
addmsg . 		K_channel 		VOLTAGE Vm

addmsg . 		Na_channel/m_gate	INPUT	Vm
addmsg . 		Na_channel/h_gate	VOLTAGE Vm
addmsg Na_channel	.			CHANNEL	Gk Ek
addmsg . 		Na_channel		VOLTAGE	Vm

ce /

