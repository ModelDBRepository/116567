//genesis

/*****This script provides synapses for connecting the neurons
******The following synapses are implemented (as separate functions):
******conn_p2i: connects the pyramidal neuron to a given number of interenuron 
*****************in a deterministic or random fashion
******make_pyr2bas: specific function to connect pyramidal cells to 
********************basket neurons
******make_pyr2olm2: specific function to connect pyramidal cells to 
********************olm neurons
******make_pyr2ax: specific function to connect pyramidal cells to TO BE IMPLEMENTED
********************axo-axonic neurons
******make_ampaoni: creates a pulse generator or pyramidal cell driven ampa 
*****************-**receptor on a basket neuron or an olm neuron
******conn_i2p: makes interneuron-to-pyramidal cell connections
******make_olm2pyr: specific function to connect olm neurons to pyramidal cells
******make_bas2pyr: specific function to connect basket neurons to 
********************pyramidal cells
******make_ax2pyr: specific function to connect axo-axonic neurons to TO BE IMPEMENTED
********************pyramidal cells
******make_olm2pyrconn: connects an olm cell to a pyramidal neuron
******make_b2pyrconn: connects a basket cell to a pyramidal neuron
******make_ax2pyrconn: connects an axo-axonic cell to a pyramidal neuron
******make_b_nw: creates a basket cell network
******conn_b2b: establishes connections between basket cells
******make_msg_nw: creates an MSGABA cell network
******conn_msg2msg: establishes a synapse between two ms-gaba cells
******conn_olm2b: establishes a synapse between an oriens --
******************lacunosum moleculare interenuron and a basket cell
******make_olm2bas: connects olm neurons to basket neurons
******conn_olm2msg: establishes a synapse between an oriens --
******************lacunosum moleculare interenuron and an MSGABA cell
******make_olm2msg: connects olm neurons to MSGABA neurons
******conn_msg2olm: connects an MSGABA neuron to an oriens interneuron
******conn_msg2b: connects an MSGABA neuron to a basket interneuron
******conn_msg2ax: connects an MSGABA neuron to an axo-axonic interneuron
******make_msg2hipi: establishes connections between MSGABA neurons and a 
*********************specified type of hippocampal interneuron
******make_GABAonmsg: creates artificially driven innervation of the 
**********************MSGABA network
******make_ampaonp: creates pulse generator-driven synapse on a pyramidal cell
******conn_pp2pyr: simulates perforant path connections using make_ampaonp on
*******************a pyramidal neuron
******/


//**** adding fields to the basket cell's soma to keep track of the number 
//of synapses from olm neurons
 
if ({exists /prot_b})
  addfield /prot_b/soma o2b
  setfield /prot_b/soma o2b 0
  addfield /prot_b/soma b2b
  setfield /prot_b/soma b2b 0
  addfield /prot_b/soma ampa
  setfield /prot_b/soma ampa 0
  addfield /prot_b/soma nmda
  setfield /prot_b/soma nmda 0
  addfield /prot_b/soma m2b
  setfield /prot_b/soma m2b 0
end

if ({exists /prot_ax})
  addfield /prot_ax/soma o2a
  setfield /prot_ax/soma o2a 0
  addfield /prot_ax/soma b2a
  setfield /prot_ax/soma b2a 0
  addfield /prot_ax/soma ampa
  setfield /prot_ax/soma ampa 0
  addfield /prot_ax/soma nmda
  setfield /prot_ax/soma nmda 0
  addfield /prot_ax/soma m2a
  setfield /prot_ax/soma m2a 0
end

if ({exists /prot_olm})
  addfield /prot_olm/soma ampa
  setfield /prot_olm/soma ampa 0
  addfield /prot_olm/soma nmda
  setfield /prot_olm/soma nmda 0
  addfield /prot_olm/soma m2o
  setfield /prot_olm/soma m2o 0
end

if ({exists /prot_pyr})
  str pyr_field_comp
  foreach pyr_field_comp ({el /prot_pyr/##[OBJECT=compartment]})
    addfield {pyr_field_comp} io2pyr
    setfield {pyr_field_comp} io2pyr 0
    addfield {pyr_field_comp} ib2pyr
    setfield {pyr_field_comp} ib2pyr 0
    addfield {pyr_field_comp} ia2pyr
    setfield {pyr_field_comp} ia2pyr 0
    addfield {pyr_field_comp} ampa
    setfield {pyr_field_comp} ampa 0    
  end
end

if ({exists /prot_msgaba})
  addfield /prot_msgaba/soma m2m
  setfield /prot_msgaba/soma m2m 0
  addfield /prot_msgaba/soma GABA_syn
  setfield /prot_msgaba/soma GABA_syn 0
  addfield /prot_msgaba/soma o2m
  setfield /prot_msgaba/soma o2m 0
  addfield /prot_msgaba/soma ampa
  setfield /prot_msgaba/soma ampa 0
end

//*****************************************************************************
//GABA_A synapse between oriens--lacunosum moleculare neuron and innervated
//pyramidale interneurons

function conn_olm2b(pre_no, post_no, g_syn)
  int pre_no                                    //# of presynaptic cell
  int post_no                                   //# of postsynaptic cell
  float g_syn                                   //synaptic conductance
  int syn_no
  int i

  syn_no = {getfield /int_b[{post_no}]/soma o2b} + 1
  setfield /int_b[{post_no}]/soma o2b {syn_no}

  if ({!{exists /prot_b/soma/syn_io2ip}})
    create vdep_channel /prot_b/soma/syn_io2ip
    ce /prot_b/soma/syn_io2ip
    create tabgate s_gate
    setfield . Ek -80e-3 gbar {{g_syn} * {SOMA_A_B}}
    setupgate s_gate alpha 2e3 0 1 {Theta_o2b} -0.5e-3 -size {VRES} -range {VMIN} {VMAX}
    call s_gate TABCREATE beta {VRES} {VMIN} {VMAX}
    for (i = 0; i<= VRES; i = i + 1)
      setfield s_gate beta->table[{i}] 0.03e3
    end
  end

  copy /prot_b/soma/syn_io2ip /int_b[{post_no}]/soma/syn_io2ip[{syn_no}]
  ce /int_b[{post_no}]/soma/syn_io2ip[{syn_no}]

  setfield . gbar {{g_syn} * {SOMA_A_B}}

  addmsg s_gate/                        .               MULTGATE m 1
  addmsg /int_b[{post_no}]/soma         .               VOLTAGE Vm
  addmsg /int_olm[{pre_no}]/soma        ./s_gate        VOLTAGE Vm
  addmsg .                      /int_b[{post_no}]/soma  CHANNEL Gk Ek

  ce /
end

//*****************************************************************************
//GABA_A synapse between basket cells

function conn_b2b(pre_no, post_no, g_syn)
  int pre_no					//# of presynaptic cell
  int post_no					//# of postsynaptic cell
  float g_syn					//synaptic conductance
  int syn_no
  int i

  syn_no = {getfield /int_b[{post_no}]/soma b2b} + 1
  setfield /int_b[{post_no}]/soma b2b {syn_no}

  if ({!{exists /prot_b/soma/syn_ip2ip}})
    create vdep_channel /prot_b/soma/syn_ip2ip
    ce /prot_b/soma/syn_ip2ip
    create tabgate s_gate
    setfield . Ek -75e-3 gbar {{g_syn} * {SOMA_A_B}}
    setupgate s_gate alpha 1e3 0 1 {Theta_b2b} -2e-3 -size {VRES} -range {VMIN} {VMAX}
    call s_gate TABCREATE beta {VRES} {VMIN} {VMAX}
    for (i = 0; i<= VRES; i = i + 1)
      setfield s_gate beta->table[{i}] 0.07e3
    end
  end

  copy /prot_b/soma/syn_ip2ip /int_b[{post_no}]/soma/syn_ip2ip[{syn_no}]
  ce /int_b[{post_no}]/soma/syn_ip2ip[{syn_no}]

  addmsg s_gate/ 		. 		MULTGATE m 1
  addmsg /int_b[{post_no}]/soma	.		VOLTAGE Vm
  addmsg /int_b[{pre_no}]/soma	./s_gate	VOLTAGE Vm
  addmsg .		/int_b[{post_no}]/soma	CHANNEL Gk Ek

  ce /
end

//*****************************************************************************
//Function for setting up a basket interneuron-network with a given connection 
//probability (cp)

function make_b_nw (cp, g_syn)
  float	cp					//connection probability
						//1 if full
  float	r
  int	i,j
  float g_syn

  if (cp>1 || cp<0)
    return
  end

  for (i = 1; i<= {N_b}; i = i + 1)
    for (j = 1; j<= {N_b}; j = j + 1)  
      r = {rand 0 1 }
      if (r<={cp} && i!=j)
        r = 1
        conn_b2b {i} {j} {g_syn}
      else
        r = 0
      end
    end
  end
end

//*****************************************************************************
//GABA_A synapse between ms-gaba neurons

function conn_msg2msg(pre_no, post_no, g_syn)
  int pre_no					//# of presynaptic cell
  int post_no					//# of postsynaptic cell
  int syn_no
  int i
  float g_syn

  syn_no = {getfield /int_msg[{post_no}]/soma m2m} + 1
  setfield /int_msg[{post_no}]/soma m2m {syn_no}

  if ({!{exists /prot_msgaba/soma/syn_m2m}})
    create vdep_channel /prot_msgaba/soma/syn_m2m
    ce /prot_msgaba/soma/syn_m2m
    create tabgate s_gate
    setfield . Ek -75e-3 gbar {{g_syn} * {SOMA_A_MSGABA}}
    setupgate s_gate alpha 1e3 0 1 {Theta_m2m} -2e-3 -size {VRES} -range {VMIN} {VMAX}
    call s_gate TABCREATE beta {VRES} {VMIN} {VMAX}
    for (i = 0; i<= VRES; i = i + 1)
      setfield s_gate beta->table[{i}] 0.07e3
    end
  end

  copy /prot_msgaba/soma/syn_m2m /int_msg[{post_no}]/soma/syn_m2m[{syn_no}]
  ce /int_msg[{post_no}]/soma/syn_m2m[{syn_no}]

  addmsg s_gate/		                . 		MULTGATE m 1
  addmsg /int_msg[{post_no}]/soma	.		VOLTAGE Vm
  addmsg /int_msg[{pre_no}]/soma	./s_gate	VOLTAGE Vm
  addmsg .		/int_msg[{post_no}]/soma	    CHANNEL Gk Ek

  ce /
end

//*****************************************************************************
//Function for setting up septal GABAergic neural network with a given 
//connection probability (cp) and synaptic coductance

function make_msg_nw (cp, g_syn)
  float	cp					//connection probability
						    //1 if full
  float	r
  int	i,j
  float g_syn

  if (cp>1 || cp<0)
    return
  end

  for (i = 1; i<= {N_msg}; i = i + 1)
    for (j = 1; j<= {N_msg}; j = j + 1)  
      r = {rand 0 1 }
      if (r<={cp} && i!=j)
        r = 1
        conn_msg2msg {i} {j} {g_syn}
      else
        r = 0
      end
    end
  end
end

//*****************************************************************************
//Spike generator- or pyramidal cell-axon-driven AMPA receptor mediated 
//synapse on a basket cell or OLM neuron (cf Destexhe in: Koch & Segev MiCM)

function make_ampaoni(post_no, gAMPA, inttype, pre_no)
  str post_no
  float gAMPA
  int syn_no
  str inttype                        //"b": basket cell, "olm": OLM neuron, "ax": axo-axonic neuron
  int pre_no                         //0: pulsegen -> i, other: pyr[other] -> i
  int i
  str postint

  postint = {strcat "int_" {inttype}}

  syn_no = {getfield /{postint}[{post_no}]/soma ampa} + 1
  setfield /{postint}[{post_no}]/soma ampa {syn_no}

  create vdep_channel /{postint}[{post_no}]/soma/AMPA_syn[{syn_no}]
  ce /{postint}[{post_no}]/soma/AMPA_syn[{syn_no}]
  create tabgate r_gate
  setfield . Ek 0 gbar {{gAMPA}*1e-9}
  setupgate r_gate \
	alpha 1.1e3 0 1 -2e-3 -5e-3 -size {VRES} -range {VMIN} {VMAX}
  call r_gate TABCREATE beta {VRES} {VMIN} {VMAX}

  for (i = 0; i<= {VRES}; i = i + 1)
    setfield r_gate beta->table[{i}] 190
  end

  addmsg r_gate 			.		MULTGATE m 1
  addmsg /{postint}[{post_no}]/soma		.		VOLTAGE Vm
  addmsg .			/{postint}[{post_no}]/soma	CHANNEL Gk Ek


  if (pre_no==0)
    create pulsegen /{postint}[{post_no}]/soma/preampa_gen[{syn_no}]
    ce /{postint}[{post_no}]/soma/preampa_gen[{syn_no}]
    setfield . baselevel -0.07
    setfield . width1 0.001
    setfield . level1 0.01
    setfield . delay1 0.159
    addmsg . /{postint}[{post_no}]/soma/AMPA_syn[{syn_no}]/r_gate	VOLTAGE output
  elif (pre_no<={N_pyr})
    addmsg /pyr[{pre_no}]/r3 /{postint}[{post_no}]/soma/AMPA_syn[{syn_no}]/r_gate     VOLTAGE Vm
  else
    echo "Wrong p2i type in make_ampaoni"
    return
  end

  ce /
end

//Spike generator- or pyramidal cell-axon-driven NMDA receptor mediated 
//synapse on a basket cell or OLM neuron (cf Destexhe in: Koch & Segev MiCM)

function make_nmdaoni(post_no, gNMDA, inttype, pre_no, mgconc, nmdatype)
  str post_no
  float gNMDA
  int syn_no
  str inttype                        //"b": basket cell, "olm": OLM neuron, "ax": axo-axonic neuron
  int pre_no                         //0: pulsegen -> i, other: pyr[other] -> i
  int i
  str postint
  float mgblock
  float mgconc                        //concentration of magnesium (in mM)
  str nmdatype
  float nmdacons1
  float nmdacons2

  if (nmdatype=="a")
    nmdacons1=-62
    nmdacons2=1.37
  elif (nmdatype=="c")
    nmdacons1=-45
    nmdacons2=1.48
  elif (nmdatype=="d")
    nmdacons1=-41
    nmdacons2=1.57
  else
    echo "Wrong nmdatype"
  end

  postint = {strcat "int_" {inttype}}

  syn_no = {getfield /{postint}[{post_no}]/soma nmda} + 1
  setfield /{postint}[{post_no}]/soma nmda {syn_no}

  create vdep_channel /{postint}[{post_no}]/soma/NMDA_syn[{syn_no}]
  ce /{postint}[{post_no}]/soma/NMDA_syn[{syn_no}]
  create tabgate r_gate
  setfield . Ek 0 gbar {{gNMDA}*1e-9}
  setupgate r_gate \
	alpha 0.072e3 0 1 -2e-3 -5e-3 -size {VRES} -range {VMIN} {VMAX}
  call r_gate TABCREATE beta {VRES} {VMIN} {VMAX}

  for (i = 0; i<= {VRES}; i = i + 1)
    setfield r_gate beta->table[{i}] 6.6
  end

  create table Mg_block
  call Mg_block TABCREATE {VRES} {VMIN} {VMAX}

  for (i = 0; i<= {VRES}; i = i + 1)
    x = (i * (VMAX - VMIN) / VRES) + VMIN
    mgblock = {1/(1+{exp {nmdacons1 * x }}*mgconc/nmdacons2)}
//1 / (1 + exp {-0.062 * x} * 1e-6 / 3.57)
    setfield Mg_block table->table[{i}] {mgblock}
  end

//  for (i = 0; i<= {VRES}; i = i + 1)
//    setfield r_gate beta->table[{i}] 190
//  end

  addmsg r_gate 						.				MULTGATE m 1
  addmsg Mg_block           			.				MULTGATE output 1
  addmsg /{postint}[{post_no}]/soma		.				VOLTAGE Vm
  addmsg /{postint}[{post_no}]/soma		Mg_block		INPUT Vm
  addmsg .				/{postint}[{post_no}]/soma		CHANNEL Gk Ek

  if (pre_no==0)
    create pulsegen /{postint}[{post_no}]/soma/prenmda_gen[{syn_no}]
    ce /{postint}[{post_no}]/soma/prenmda_gen[{syn_no}]
    setfield . baselevel -0.07
    setfield . width1 0.002
    setfield . level1 0.02
    setfield . delay1 0.152
    setfield . width2 0.002
    setfield . level2 0.02
    setfield . delay2 0.006
    addmsg . /{postint}[{post_no}]/soma/NMDA_syn[{syn_no}]/r_gate	VOLTAGE output
  elif (pre_no<={N_pyr})
    addmsg /pyr[{pre_no}]/r3 /{postint}[{post_no}]/soma/NMDA_syn[{syn_no}]/r_gate     VOLTAGE Vm
  else
    echo "Wrong p2i type in make_nmdaoni"
    return
  end

  ce /
end


//*****************************************************************************
//AMPA and/or NMDA receptor mediated synapse on
//interenurons (cf Destexhe in: Koch & Segev MiCM)

function conn_p2i(pre_no, gAMPA, gNMDA, divp, inttype, mgconc, nmdatype, random)
  int pre_no             //# of presynaptic neuron
  float gAMPA             //maximal conductance of the ampa synapse (set 0 if no)
  float gNMDA             //maximal conductance of the nmda synapse (set 0 if no)
  int divp                //number of basket cells to be innervated
  str inttype             //"b": basket cell, "olm": OLM neuron, "ax": axo-axonic neuron
  float mgconc                  //magnesium concentration for the nmda rec (set 0 if no NMDA)
  str nmdatype                //subunit type of the nmda rec ("a", "c", or "d")
  int random              //1: random connections, 0: deterministic connections
  int inttype_no
  int syn_no
  int i
  int j = 0
  int t = 0
  int r = 0

  if (inttype=="olm")
    inttype_no=N_olm
  elif (inttype=="ax")
    inttype_no=N_ax
  else
    inttype_no=N_b
  end

  create table /p2{inttype}_list[{pre_no}]
  call /p2{inttype}_list[{pre_no}] TABCREATE {divp-1} 0 1
  for(i=0; i<={divp-1}; i=i+1)
    setfield /p2{inttype}_list[{pre_no}] table->table[{i}] 0
  end

  if(divp > inttype_no)
    echo "conn_p2i: more p->i connections than i! Multiple connections are not allowed. Exiting."
    exit
  end

  while (j < divp)
    r = {rand 1 {inttype_no + 0.9}}
    for(i=0; i<{j}; i=i+1)
      if({getfield /p2{inttype}_list[{pre_no}] table->table[{i}]} == r)
	t=1
      end
    end
    if(t != 1)
      setfield /p2{inttype}_list[{pre_no}] table->table[{j}] {r}
      j = j+1
    end
    t = 0
  end

  if (gAMPA!=0)
    for (i=0; i<{divp}; i=i+1) //Connect pyr to inteenurons with AMPA
      if (random==1)
        make_ampaoni {getfield /p2{inttype}_list[{pre_no}] table->table[{i}]} {gAMPA} {inttype} {pre_no}
      else
        make_ampaoni {i+1} {gAMPA} {inttype} {pre_no} // ez igy talan egy kicsit koltseges, bar nem sokat szamit
      end
    end
  end

  if (gNMDA!=0)
    for (i=0; i<{divp}; i=i+1) //Connect pyr to inteenurons
      if (random==1)
        make_nmdaoni {getfield /p2{inttype}_list[{pre_no}] table->table[{i}]} {gNMDA} {inttype} {pre_no} {mgconc} {nmdatype}
      else
        make_nmdaoni {i+1} {gNMDA} {inttype} {pre_no} {mgconc} {nmdatype} 
// ez igy talan egy kicsit koltseges, bar nem sokat szamit
      end
    end
  end
end


//**************************************************************************
//NMDA mediated synapses between pyramidal cells and intereurons

function conn_p2iwn(pre_no, gNMDA, divp, inttype, random,mgconc,nmdatype)
  int pre_no             //# of presynaptic neuron
  float gNMDA             //maximal conductance of the ampa synapse
  int divp                //number of basket cells to be innervated
  str inttype             //"b": basket cell, "olm": OLM neuron, "ax": axo-axonic neuron
  int random              //1: random connections, 0: deterministic connections
  int inttype_no
  int syn_no
  int i
  int j = 0
  int t = 0
  int r = 0
  float mgconc
  str nmdatype

  if (inttype=="olm")
    inttype_no=N_olm
  elif (inttype=="ax")
    inttype_no=N_ax
  else
    inttype_no=N_b
  end

  if ({!{exists /p2{inttype}_list[{pre_no}]}})
    create table /p2{inttype}_list[{pre_no}]
    call /p2{inttype}_list[{pre_no}] TABCREATE {divp-1} 0 1
    for(i=0; i<={divp-1}; i=i+1)
        setfield /p2{inttype}_list[{pre_no}] table->table[{i}] 0
    end

    if(divp > inttype_no)
        echo "conn_p2i: more p->i connections than i! Multiple connections are not allowed. Exiting."
        exit
    end

    while (j < divp)
        r = {rand 1 {inttype_no + 0.9}}
        for(i=0; i<{j}; i=i+1)
            if({getfield /p2{inttype}_list[{pre_no}] table->table[{i}]} == r)
                t=1
            end
        end
        if(t != 1)
            setfield /p2{inttype}_list[{pre_no}] table->table[{j}] {r}
            j = j+1
        end
        t = 0
    end
  end

  for (i=0; i<{divp}; i=i+1) //Connect pyr to inteenurons
    if (random==1)
      make_nmdaoni {getfield /p2{inttype}_list[{pre_no}] table->table[{i}]} {gNMDA} {inttype} {pre_no} {mgconc} {nmdatype}
    else
      make_nmdaoni {i+1} {gNMDA} {inttype} {pre_no} {mgconc} {nmdatype} 
// ez igy talan egy kicsit koltseges, bar nem sokat szamit
    end
  end
end

//*****************************************************************************
//*****************************************************************************
//Spike generator-driven NMDA receptor mediated synapse on a
//basket cell (cf Destexhe in: Koch & Segev MiCM)

function make_nmdaonb(post_no, gNMDA)
  str post_no
  float gNMDA
  int syn_no
  int i
  float tconc                                       //trasnmitter concentration
  float mgblock                                     //Mg block on the channel
  float an = 7.2
  float bn = 6.6
  float x
  float arn, brn

  syn_no = {getfield /int_b[{post_no}]/soma ampa} + 1
  setfield /int_b[{post_no}]/soma ampa {syn_no}

  addmsg r_gate 			.		MULTGATE m 1
  addmsg /int_b[{post_no}]/soma		.		VOLTAGE Vm
  addmsg .			/int_b[{post_no}]/soma	CHANNEL Gk Ek

  create pulsegen /int_b[{post_no}]/soma/prenmda_gen[{syn_no}]
  ce /int_b[{post_no}]/soma/prenmda_gen[{syn_no}]
  setfield . baselevel -0.06
  setfield . width1 0.001
  setfield . level1 0.01
  setfield . delay1 0.199

  addmsg . /int_b[{post_no}]/soma/NMDA_syn[{syn_no}]/r_gate	VOLTAGE output

  ce /
end

//*****************************************************************************
//GABA_A synapse between oriens--lacunosum moleculare interneurons and the 
//pyramidal neuron

function make_olm2pyrconn(pre_no, post_no, post_comp, g_syn)
  int pre_no					//# of presynaptic cell
  int post_no					//# of postsynaptic cell
  str post_comp					//innervated compartment of postsynaptic cell
  float g_syn					//synaptic conductance
  int syn_no
  int i

  syn_no = {getfield /pyr[{post_no}]/{post_comp} io2pyr} + 1
  setfield /pyr[{post_no}]/{post_comp} io2pyr {syn_no}

  if ({!{exists /prot_pyr/{post_comp}/syn_iolm2pyr}})
    create vdep_channel /prot_pyr/{post_comp}/syn_iolm2pyr
    ce /prot_pyr/{post_comp}/syn_iolm2pyr
    create tabgate s_gate
    setfield . Ek -85e-3 gbar {{g_syn} * {SOMA_A_OLM}}
    setupgate s_gate alpha 2e3 0 1 {Theta} -0.5e-3 -size {VRES} -range {VMIN} {VMAX}
    call s_gate TABCREATE beta {VRES} {VMIN} {VMAX}
    for (i = 0; i<= VRES; i = i + 1)
      setfield s_gate beta->table[{i}] 0.05e3
    end
  end

  copy /prot_pyr/{post_comp}/syn_iolm2pyr /pyr[{post_no}]/{post_comp}/syn_iolm2pyr[{syn_no}]
  ce /pyr[{post_no}]/{post_comp}/syn_iolm2pyr[{syn_no}]

  setfield . gbar {{g_syn} * {SOMA_A_OLM}}

  addmsg s_gate/ 		. 		MULTGATE m 1
  addmsg /pyr[{post_no}]/{post_comp}	.		VOLTAGE Vm
  addmsg /int_olm[{pre_no}]/soma	./s_gate	VOLTAGE Vm
  addmsg .		/pyr[{post_no}]/{post_comp}	CHANNEL Gk Ek

  ce /
end

//for the holy sake of backward compatibility...

function conn_olm2pyr(pre_no, post_no, post_comp, g_syn)
    int pre_no
    int post_no
    str post_comp
    float g_syn
    make_olm2pyrconn {pre_no} {post_no} {post_comp} {g_syn}
end

//*****************************************************************************
//GABA_A synapse basket interneurons and the 
//pyramidal neuron

function make_b2pyrconn(pre_no, post_no, post_comp, g_syn)
  int pre_no					//# of presynaptic cell
  int post_no					//# of postsynaptic cell
  str post_comp					//innervated compartment of postsynaptic cell
  float g_syn					//synaptic conductance
  int syn_no
  int i

  syn_no = {getfield /pyr[{post_no}]/{post_comp} ib2pyr} + 1
  setfield /pyr[{post_no}]/{post_comp} ib2pyr {syn_no}

  if ({!{exists /prot_pyr/{post_comp}/syn_ib2pyr}})
    create vdep_channel /prot_pyr/{post_comp}/syn_ib2pyr
    ce /prot_pyr/{post_comp}/syn_ib2pyr
    create tabgate s_gate
    setfield . Ek -80e-3 gbar {{g_syn} * {SOMA_A_B}}
    setupgate s_gate alpha 1e3 0 1 {Theta_b2b} -2e-3 -size {VRES} -range {VMIN} {VMAX}
    call s_gate TABCREATE beta {VRES} {VMIN} {VMAX}
    for (i = 0; i<= VRES; i = i + 1)
      setfield s_gate beta->table[{i}] 0.07e3
    end
  end

  copy /prot_pyr/{post_comp}/syn_ib2pyr /pyr[{post_no}]/{post_comp}/syn_ib2pyr[{syn_no}]
  ce /pyr[{post_no}]/{post_comp}/syn_ib2pyr[{syn_no}]

  setfield . gbar {{g_syn} * {SOMA_A_B}}

  addmsg s_gate/ 		        . 		    MULTGATE m 1
  addmsg /pyr[{post_no}]/{post_comp}	.		    VOLTAGE Vm
  addmsg /int_b[{pre_no}]/soma	./s_gate	VOLTAGE Vm
  addmsg .		/pyr[{post_no}]/{post_comp}	        CHANNEL Gk Ek

  ce /
end

//for the holy sake of backward compatibility...

function conn_ib2pyr(pre_no, post_no, post_comp, g_syn)
    int pre_no
    int post_no
    str post_comp
    float g_syn
    make_b2pyrconn {pre_no} {post_no} {post_comp} {g_syn}
end

//*****************************************************************************
//GABA_A synapse between an axo-axonic interneuron and a
//pyramidal neuron

function make_ax2pyrconn(pre_no, post_no, post_comp, g_syn)
  int pre_no					//# of presynaptic cell
  int post_no					//# of postsynaptic cell
  str post_comp					//innervated compartment of postsynaptic cell
  float g_syn					//synaptic conductance
  int syn_no
  int i

  syn_no = {getfield /pyr[{post_no}]/{post_comp} ia2pyr} + 1
  setfield /pyr[{post_no}]/{post_comp} ia2pyr {syn_no}

  if ({!{exists /prot_pyr/{post_comp}/syn_ia2pyr}})
    create vdep_channel /prot_pyr/{post_comp}/syn_ia2pyr
    ce /prot_pyr/{post_comp}/syn_ia2pyr
    create tabgate s_gate
    setfield . Ek -80e-3 gbar {{g_syn} * {SOMA_A_AX}}
    setupgate s_gate alpha 1e3 0 1 {Theta_ax} -2e-3 -size {VRES} -range {VMIN} {VMAX}
    call s_gate TABCREATE beta {VRES} {VMIN} {VMAX}
    for (i = 0; i<= VRES; i = i + 1)
      setfield s_gate beta->table[{i}] 0.07e3
    end
  end

  copy /prot_pyr/{post_comp}/syn_ia2pyr /pyr[{post_no}]/{post_comp}/syn_ia2pyr[{syn_no}]
  ce /pyr[{post_no}]/{post_comp}/syn_ia2pyr[{syn_no}]

  setfield . gbar {{g_syn} * {SOMA_A_AX}}

  addmsg s_gate/ 		        . 		    MULTGATE m 1
  addmsg /pyr[{post_no}]/{post_comp}	.		    VOLTAGE Vm
  addmsg /int_ax[{pre_no}]/soma	./s_gate	VOLTAGE Vm
  addmsg .		/pyr[{post_no}]/{post_comp}	        CHANNEL Gk Ek

  ce /
end


//*****************************************************************************
//GABA receptor mediated synapse on
//pyramidal neurons

function conn_i2p(post_no, post_comp, gGABA, convp, inttype, initcell)
  int post_no             //# of postsynaptic pyramidal neuron
  str post_comp           //compartment of the pyramidal cell to innervate
  float gGABA             //maximal conductance of the GABA synapse
  int convp               //number of basket cells innervating a pyramidal cell
  str inttype             //"b": basket cell, "olm": OLM neuron, "ax": axo-axonic neuron
  int initcell            //0: random connections, else:deterministic with
                          //first neuron to connect being $initcell
  int inttype_no
  int syn_no
  int i
  int j = 0
  int t = 0
  int r = 0
  str listname

  if (inttype=="olm")
    inttype_no=N_olm
  elif (inttype=="ax")
    inttype_no=N_ax
  else
    inttype_no=N_b
  end

  listname={strcat {inttype} {strcat "2p" {strcat {post_comp} "_list"}}}
  create table /{listname}[{post_no}]
  call /{listname}[{post_no}] TABCREATE {convp-1} 0 1
  for(i=0; i<={convp-1}; i=i+1)
    setfield /{listname}[{post_no}] table->table[{i}] 0
  end

  while (j < convp)
    r = {rand 1 {inttype_no + 0.9}}
    for(i=0; i<{j}; i=i+1)
      if({getfield /{listname}[{post_no}] table->table[{i}]} == r)
	t=1
      end
    end
    if(t != 1)
      setfield /{listname}[{post_no}] table->table[{j}] {r}
      j = j+1
    end
    t = 0
  end

  for (i=0; i<{convp}; i=i+1) //Connect interneuron to pyr
    if (initcell==0)
      make_{inttype}2pyrconn {getfield /{listname}[{post_no}] table->table[{i}]} {post_no} {post_comp} {gGABA}
    else
      make_{inttype}2pyrconn {i+initcell} {post_no} {post_comp} {gGABA}
    end
  end
end

//*****************************************************************************
//periodic hyperpolarizing current generator on the pyramidal neuron

function make_genonpyr(pyrno, ihyp, time)
  create pulsegen /pyr[{pyrno}]/soma/pregaba_gen
  ce /pyr[{pyrno}]/soma/pregaba_gen
  setfield . baselevel 1e-12
  setfield . width1 0.020
  setfield . level1 {ihyp}
  setfield . delay1 {{time} - 0.02}
  addmsg . /pyr[{pyrno}]/soma	INJECT output
end

//*****************************************************************************
//GABA_A synapse on MSGABA cells driven by a pulse generator

function make_GABAonmsg(post_no, gGABA)
  int post_no                                   //# of postsynaptic cell
  float gGABA                                   //synaptic conductance
  int syn_no
  int i

  syn_no = {getfield /int_msg[{post_no}]/soma GABA_syn} + 1
  setfield /int_msg[{post_no}]/soma GABA_syn {syn_no}

  create vdep_channel /int_msg[{post_no}]/soma/GABA_syn[{syn_no}]
  ce /int_msg[{post_no}]/soma/GABA_syn[{syn_no}]
  create tabgate s_gate
  setfield . Ek -80e-3 gbar {{gGABA} * {SOMA_A_MSGABA}}
  setupgate s_gate alpha 2e3 0 1 {Theta_GABA} -0.5e-3 -size {VRES} -range {VMIN} {VMAX}
  call s_gate TABCREATE beta {VRES} {VMIN} {VMAX}
  for (i = 0; i<= VRES; i = i + 1)
    setfield s_gate beta->table[{i}] 0.03e3
  end

  addmsg s_gate/                        .               MULTGATE m 1
  addmsg /int_msg[{post_no}]/soma         .               VOLTAGE Vm
  addmsg .                      /int_msg[{post_no}]/soma  CHANNEL Gk Ek

  create pulsegen /int_msg[{post_no}]/soma/preGABA_gen[{syn_no}]
  ce /int_msg[{post_no}]/soma/preGABA_gen[{syn_no}]
  setfield . baselevel -0.06
  setfield . width1 0.001
  setfield . level1 0.01
  setfield . delay1 1

  addmsg . /int_msg[{post_no}]/soma/GABA_syn[{syn_no}]/s_gate	VOLTAGE output

  ce /
end

/*protype GABA synapse intended for testing purpose only*/

function make_gabaoni(post_no, gGABA, inttype, gabadrive)
  str post_no
  float gGABA                            //note that it is given in nS!!!
  int syn_no
  str inttype                            //"b": basket cell, "olm": OLM neuron, "ax":axo-axonic neurons
  int gabadrive                          //0: pulsegen -> i
  int i
  str postint

  postint = {strcat "int_" {inttype}}

  if ({!{exists /{postint}[{post_no}]/soma/syn_GABAprot}})
    create vdep_channel /{postint}[{post_no}]/soma/syn_GABAprot
    ce /{postint}[{post_no}]/soma/syn_GABAprot
    create tabgate s_gate
    setfield . Ek -75e-3 gbar {{gGABA} * {SOMA_A_B}}
    setupgate s_gate alpha 2e3 0 1 {Theta_o2b} -0.5e-3 -size {VRES} -range {VMIN} {VMAX}
    call s_gate TABCREATE beta {VRES} {VMIN} {VMAX}
    for (i = 0; i<= VRES; i = i + 1)
      setfield s_gate beta->table[{i}] 0.03e3
    end
  end

  setfield . gbar {{gGABA}*1e-9}

  addmsg s_gate/                        .               MULTGATE m 1
  addmsg /{postint}[{post_no}]/soma         .               VOLTAGE Vm
  addmsg .                      /{postint}[{post_no}]/soma  CHANNEL Gk Ek

  ce /

  if (gabadrive==0)
    create pulsegen /{postint}[{post_no}]/soma/pregaba_gen
    ce /{postint}[{post_no}]/soma/pregaba_gen
    setfield . baselevel -0.07
    setfield . width1 0.001
    setfield . level1 0.01
    setfield . delay1 0.399
    addmsg . /{postint}[{post_no}]/soma/syn_GABAprot/s_gate	VOLTAGE output
  elif (gabadrive==1)
    echo "currently not implemented"
  else
    echo "Wrong p2i type in make_ampaoni"
    return
  end

  ce /
end

function conn_olm2msg(pre_no, post_no, g_syn)
  int pre_no                                    //# of presynaptic cell
  int post_no                                   //# of postsynaptic cell
  float g_syn                                   //synaptic conductance
  int syn_no
  int i

  syn_no = {getfield /int_msg[{post_no}]/soma o2m} + 1
  setfield /int_msg[{post_no}]/soma o2m {syn_no}

  if ({!{exists /prot_msgaba/soma/syn_io2im}})
    create vdep_channel /prot_msgaba/soma/syn_io2im
    ce /prot_msgaba/soma/syn_io2im
    create tabgate s_gate
    setfield . Ek -80e-3 gbar {{g_syn} * {SOMA_A_MSGABA}}
    setupgate s_gate alpha 2e3 0 1 {Theta_o2m} -0.5e-3 -size {VRES} -range {VMIN} {VMAX}
    call s_gate TABCREATE beta {VRES} {VMIN} {VMAX}
    for (i = 0; i<= VRES; i = i + 1)
      setfield s_gate beta->table[{i}] 0.05e3
    end
  end

  copy /prot_msgaba/soma/syn_io2im /int_msg[{post_no}]/soma/syn_io2im[{syn_no}]
  ce /int_msg[{post_no}]/soma/syn_io2im[{syn_no}]

  setfield . gbar {{g_syn} * {SOMA_A_MSGABA}}

  addmsg s_gate/                        .               MULTGATE m 1
  addmsg /int_msg[{post_no}]/soma         .               VOLTAGE Vm
  addmsg /int_olm[{pre_no}]/soma        ./s_gate        VOLTAGE Vm
  addmsg .                      /int_msg[{post_no}]/soma  CHANNEL Gk Ek

  ce /
end



function conn_msg2olm(pre_no, post_no, g_syn)
  int pre_no                                    //# of presynaptic cell
  int post_no                                   //# of postsynaptic cell
  float g_syn                                   //synaptic conductance
  int syn_no
  int i

  syn_no = {getfield /int_olm[{post_no}]/soma m2o} + 1
  setfield /int_olm[{post_no}]/soma m2o {syn_no}

  if ({!{exists /prot_olm/soma/syn_im2io}})
    create vdep_channel /prot_olm/soma/syn_im2io
    ce /prot_olm/soma/syn_im2io
    create tabgate s_gate
    setfield . Ek -80e-3 gbar {{g_syn} * {SOMA_A_OLM}}
    setupgate s_gate alpha 1e3 0 1 {Theta_m2o} -2e-3 -size {VRES} -range {VMIN} {VMAX}
    call s_gate TABCREATE beta {VRES} {VMIN} {VMAX}
    for (i = 0; i<= VRES; i = i + 1)
      setfield s_gate beta->table[{i}] 0.07e3
    end
  end

  copy /prot_olm/soma/syn_im2io /int_olm[{post_no}]/soma/syn_im2io[{syn_no}]
  ce /int_olm[{post_no}]/soma/syn_im2io[{syn_no}]

  setfield . gbar {{g_syn} * {SOMA_A_OLM}}

  addmsg s_gate/                        .               MULTGATE m 1
  addmsg /int_olm[{post_no}]/soma         .               VOLTAGE Vm
  addmsg /int_msg[{pre_no}]/soma        ./s_gate        VOLTAGE Vm
  addmsg .                      /int_olm[{post_no}]/soma  CHANNEL Gk Ek

  ce /
end


function conn_msg2b(pre_no, post_no, g_syn)
  int pre_no                                    //# of presynaptic cell
  int post_no                                   //# of postsynaptic cell
  float g_syn                                   //synaptic conductance
  int syn_no
  int i

  syn_no = {getfield /int_b[{post_no}]/soma m2b} + 1
  setfield /int_b[{post_no}]/soma m2b {syn_no}

  if ({!{exists /prot_b/soma/syn_im2ib}})
    create vdep_channel /prot_b/soma/syn_im2ib
    ce /prot_b/soma/syn_im2ib
    create tabgate s_gate
    setfield . Ek -80e-3 gbar {{g_syn} * {SOMA_A_B}}
    setupgate s_gate alpha 1e3 0 1 {Theta_m2b} -2e-3 -size {VRES} -range {VMIN} {VMAX}
    call s_gate TABCREATE beta {VRES} {VMIN} {VMAX}
    for (i = 0; i<= VRES; i = i + 1)
      setfield s_gate beta->table[{i}] 0.07e3
    end
  end

  copy /prot_b/soma/syn_im2ib /int_b[{post_no}]/soma/syn_im2ib[{syn_no}]
  ce /int_b[{post_no}]/soma/syn_im2ib[{syn_no}]

  setfield . gbar {{g_syn} * {SOMA_A_B}}

  addmsg s_gate/                        .               MULTGATE m 1
  addmsg /int_b[{post_no}]/soma         .               VOLTAGE Vm
  addmsg /int_msg[{pre_no}]/soma        ./s_gate        VOLTAGE Vm
  addmsg .                      /int_b[{post_no}]/soma  CHANNEL Gk Ek

  ce /
end


function conn_msg2ax(pre_no, post_no, g_syn)
  int pre_no                                    //# of presynaptic cell
  int post_no                                   //# of postsynaptic cell
  float g_syn                                   //synaptic conductance
  int syn_no
  int i

  syn_no = {getfield /int_ax[{post_no}]/soma m2a} + 1
  setfield /int_ax[{post_no}]/soma m2a {syn_no}

  if ({!{exists /prot_ax/soma/syn_im2ia}})
    create vdep_channel /prot_ax/soma/syn_im2ia
    ce /prot_ax/soma/syn_im2ia
    create tabgate s_gate
    setfield . Ek -80e-3 gbar {{g_syn} * {SOMA_A_AX}}
    setupgate s_gate alpha 1e3 0 1 {Theta_m2a} -2e-3 -size {VRES} -range {VMIN} {VMAX}
    call s_gate TABCREATE beta {VRES} {VMIN} {VMAX}
    for (i = 0; i<= VRES; i = i + 1)
      setfield s_gate beta->table[{i}] 0.07e3
    end
  end

  copy /prot_ax/soma/syn_im2ia /int_ax[{post_no}]/soma/syn_im2ia[{syn_no}]
  ce /int_ax[{post_no}]/soma/syn_im2ia[{syn_no}]

  setfield . gbar {{g_syn} * {SOMA_A_AX}}

  addmsg s_gate/                        .               MULTGATE m 1
  addmsg /int_ax[{post_no}]/soma         .               VOLTAGE Vm
  addmsg /int_msg[{pre_no}]/soma        ./s_gate        VOLTAGE Vm
  addmsg .                      /int_ax[{post_no}]/soma  CHANNEL Gk Ek

  ce /
end




function make_olm2bas(amo_of_1, ob_gb)
int amo_of_1 // gives how many basket cells are innervated by a single olm cell
int i = 0
int j = 0
int k = 0
float ob_gb
int r
int t = 0

    if (amo_of_1 > N_b)
        echo "make_olm2bas: multiple connections not allowed"
        exit
    end

    create table /o2b_list //table to store # of b to connect current olm to
    call /o2b_list TABCREATE {amo_of_1} 0 1
    
    for (i = 1; i <= {N_olm}; i = i + 1)
        for (j = 0; j <= {amo_of_1-1}; j = j + 1)
            setfield /o2b_list table->table[{j}] 0
        end
        j = 0
        while (j < amo_of_1)
            r = {rand 1 {N_b + 0.9}}
            for (k = 0; k < {j}; k = k + 1)
                if ({getfield /o2b_list table->table[{k}]} == r)
                    t=1
                end
            end
            if (t != 1)
                setfield /o2b_list table->table[{j}] {r}
                j = j+1
            end
            t = 0
        end
        for (j = 0; j < {amo_of_1}; j = j + 1) //Connect olm to amo_of_1 piece of basket
            conn_olm2b {i} {getfield /o2b_list table->table[{j}]} {ob_gb}
        end
    end
    delete /o2b_list //no more need for this
end



function make_olm2msg(amo_of_1, gb)
int amo_of_1 // gives how many basket cells are innervated by a single olm cell
float gb
int i = 0
int j = 0
int k = 0
int r = 0
int t = 0

    if (amo_of_1 > N_msg)
        echo "make_olm2msg: multiple connections not allowed"
        exit
    end

    create table /o2m_list //table to store # of msg to connect current olm to
    call /o2m_list TABCREATE {amo_of_1} 0 1
    
    for (i = 1; i <= {N_olm}; i = i + 1)
        for (j = 0; j <= {amo_of_1-1}; j = j + 1)
            setfield /o2m_list table->table[{j}] 0
        end
        j = 0
        while (j < amo_of_1)
            r = {rand 1 {N_msg + 0.9}}
            for (k = 0; k < {j}; k = k + 1)
                if ({getfield /o2m_list table->table[{k}]} == r)
                    t=1
                end
            end
            if (t != 1)
                setfield /o2m_list table->table[{j}] {r}
                j = j+1
            end
            t = 0
        end
        for (j = 0; j < {amo_of_1}; j = j + 1) //Connect olm to amo_of_1 piece of msgaba
            conn_olm2msg {i} {getfield /o2m_list table->table[{j}]} {gb}
        end
    end
    delete /o2m_list //no more need for this
end



function make_olm2pyr(olm_per_pyr, gb, olmpcomp)
int olm_per_pyr
float gb
str olmpcomp
int i, j

//generates as many as {olm_per_pyr} synaptic contacts on every pyramidal 
//cell compartments listed in olmpcomp (compartmentnames separated by spaces)

    if (olm_per_pyr > N_olm)
        echo "make_olm2pyr: multiple connections not allowed"
        exit
    end
    
    for (i = 1; i <= {N_pyr}; i = i + 1)
        for (j = 1; j<={getarg {arglist {olmpcomp}} -count}; j=j+1)
            conn_i2p {i} {getarg {arglist {olmpcomp}} -arg {j}} {gb} {olm_per_pyr} "olm" 0
        end
    end
end



function make_bas2pyr(bas_per_pyr, gb, bpcomp)
int bas_per_pyr
float gb
str bpcomp
int i,j

//generates as many as {bas_per_pyr} synaptic contacts on every pyramidal 
//cell compartments listed in olmpcomp (compartmentnames separated by spaces)

    if (bas_per_pyr > N_b)
        echo "make_bas2pyr: multiple connections not allowed"
        exit
    end
    
    for (i = 1; i <= {N_pyr}; i = i + 1)
        for (j = 1; j<={getarg {arglist {bpcomp}} -count}; j=j+1)
            conn_i2p {i} {getarg {arglist {bpcomp}} -arg {j}} {gb} {bas_per_pyr} "b" 0
        end
    end
end



function make_pyr2olm2(olm_per_pyr, gAMPA, gNMDA, mgconc, nmdatype)
int olm_per_pyr
float gAMPA, gNMDA, mgconc
str mgconc

    if (olm_per_pyr > N_olm)
        echo "make_pyr2olm: multiple connections not allowed"
        exit
    end

    for (i = 1; i <= {N_pyr}; i = i + 1)
        conn_p2i {i} {gAMPA} {gNMDA} {olm_per_pyr} "olm" {mgconc} {nmdatype} 1
    end
end

//nem hasznalt fuggveny:

function make_pyr2olmNMDA(olm_per_pyr, gb,mgconc, nmdatype)
int olm_per_pyr
float gb
float mgconc
str nmdatype

    if (olm_per_pyr > N_olm)
        echo "make_pyr2olm: multiple connections not allowed"
        exit
    end

    for (i = 1; i <= {N_pyr}; i = i + 1)
        conn_p2iwn {i} {gb} {olm_per_pyr} "olm" 1 {mgconc} {nmdatype}
    end
end



function make_pyr2bas2(bas_per_pyr, gAMPA, gNMDA, mgconc, nmdatype)
int bas_per_pyr
float gAMPA, gNMDA, mgconc
str mgconc

    if (bas_per_pyr > N_b)
        echo "make_pyr2bas: multiple connections not allowed"
        exit
    end

    for (i = 1; i <= {N_pyr}; i = i + 1)
        conn_p2i {i} {gAMPA} {gNMDA} {bas_per_pyr} "b" {mgconc} {nmdatype} 1
    end
end


function make_msg2hipi(pre_am, post_am, gb, hipitype)
int pre_no
int post_no
float gb
str hipitype
int j = 0
int k = 0
int i = 0
int r = 0
int t = 0
int hipino = 0

    if ( hipitype == "olm" )
        hipino = N_olm
    elif ( hipitype == "b" )
        hipino = N_b
    elif ( hipitype == "ax" )
        hipino = N_ax
    else
        echo "make_msg2hipi: unknown / unimplemented hippocampal interrneuron type. Bummer."
        exit
    end

    if ( (pre_am > N_msg) || (post_am > hipino) )
        echo "make_msg2hipi: multiple connections not allowed / not enough cells for this"
        exit
    end

    create table /im2{hipitype}_list 
    call /im2{hipitype}_list TABCREATE {pre_am} 0 1
    
    j = 0
    while (j < pre_am)
        r = {rand 1 {N_msg + 0.9}}
        for (k = 0; k < {j}; k = k + 1)
            if ({getfield /im2{hipitype}_list table->table[{k}]} == r)
                t=1
            end
        end
        if (t != 1)
            setfield /im2{hipitype}_list table->table[{j}] {r}
            j = j+1
        end
        t = 0
    end

    create table /m2{hipitype}_list
    call /m2{hipitype}_list TABCREATE {post_am} 0 1
    
    for (i = 0; i <= {pre_am - 1}; i = i + 1)
        for (j = 0; j <= {post_am-1}; j = j + 1)
            setfield /m2{hipitype}_list table->table[{j}] 0
        end
        j = 0
        while (j < post_am)
            r = {rand 1 {hipino + 0.9}}
            for (k = 0; k < {j}; k = k + 1)
                if ({getfield /m2{hipitype}_list table->table[{k}]} == r)
                    t=1
                end
            end
            if (t != 1)
                setfield /m2{hipitype}_list table->table[{j}] {r}
                j = j+1
            end
            t = 0
        end
        for (j = 0; j < {post_am}; j = j + 1) //Connect olm to post_am piece of msgaba
            conn_msg2{hipitype} {getfield /im2{hipitype}_list table->table[{i}]} {getfield /m2{hipitype}_list table->table[{j}]} {gb}
        end
    end
    delete /m2{hipitype}_list
    delete /im2{hipitype}_list
end

//*****************************************************************************
//Spike generator-driven AMPA receptor mediated 
//synapse on pyramidal neurons (cf Destexhe in: Koch & Segev MiCM)

function make_ampaonp(post_no, post_comp, gAMPA, fr)
  str post_no
  str post_comp
  float gAMPA                             //conductance of the synapse
  float fr                                //frquency of stimulation
  int syn_no
  int i

  syn_no = {getfield /pyr[{post_no}]/{post_comp} ampa} + 1
  setfield /pyr[{post_no}]/{post_comp} ampa {syn_no}

  if ({!{exists /prot_pyr/soma/AMPA_syn}})
    create vdep_channel /prot_pyr/soma/AMPA_syn
    ce /prot_pyr/soma/AMPA_syn
    create tabgate r_gate
    setfield . Ek 0 gbar {{gAMPA}*1e-9}
    setupgate r_gate \
	  alpha 1.1e3 0 1 -2e-3 -5e-3 -size {VRES} -range {VMIN} {VMAX}
    call r_gate TABCREATE beta {VRES} {VMIN} {VMAX}
    for (i = 0; i<= {VRES}; i = i + 1)
      setfield r_gate beta->table[{i}] 190
    end
  end

  copy /prot_pyr/soma/AMPA_syn /pyr[{post_no}]/{post_comp}/AMPA_syn[{syn_no}]
  ce /pyr[{post_no}]/{post_comp}/AMPA_syn[{syn_no}]

  setfield . gbar {{gAMPA}*1e-9}

  addmsg r_gate 			.		MULTGATE m 1
  addmsg /pyr[{post_no}]/{post_comp}		.		VOLTAGE Vm
  addmsg .			/pyr[{post_no}]/{post_comp}	CHANNEL Gk Ek

  create pulsegen /pyr[{post_no}]/{post_comp}/preampa_gen[{syn_no}]
    ce /pyr[{post_no}]/{post_comp}/preampa_gen[{syn_no}]
    setfield . baselevel -0.07
    setfield . width1 0.001
    setfield . level1 0.01
    setfield . delay1 {1/{fr}-0.001}
    addmsg . /pyr[{post_no}]/{post_comp}/AMPA_syn[{syn_no}]/r_gate	VOLTAGE output
  ce /
end

function conn_pp2pyr(pyram, pyr_comps, gAMPA, fr)
int pyram                   //amount pf pyramidal cells innervated by the PP
                            //(typically {N_pyr}
str pyrcomps                //list (spaated by spaces) containing compartments 
                            //to be innervated
float gAMPA                 //maximal conductance
float fr                    //frequency of the stimulation coming from PP
int i, j

    if (pyram > N_pyr)
        echo "conn_pp2pyr: too many connections to be established"
        exit
    end
    
    for (i = 1; i <= {N_pyr}; i = i + 1)
        for (j = 1; j<={getarg {arglist {pyr_comps}} -count}; j=j+1)
            make_ampaonp {i} {getarg {arglist {pyr_comps}} -arg {j}} {gAMPA} {fr}
        end
    end

end
