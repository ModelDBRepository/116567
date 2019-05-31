//genesis

/*****This script controls the output of the simulations
******
******Functions implemented followed by parameters:
******1, spike_rec_setup $SIM_TIME $OUTPUT_TYPE $NEURON_TYPE $SPIKE_TRAIN_NO
******2, spike_rec_save
******/

str recs=""				//string of names of tables containing
					//recordings

//*****Table for the spiketrains
create neutral /spktrns

//*****Raster diagram and/or spike train recording tool************************

function spike_rec_setup(time,sr,type,no)
float	time				//simulation time
int	no				//number of spike trains recorded
str	type				//type of neuron: olm
int	sr				//swich of output types: 1, raster;
					//2, spike tr; 3 raster + spike tr
str	cellp				//path to the neurons
str	compp				//path to the compartments
int	i,total
int	table_no = 0			//total number of allocated data tables
int res

ce /spktrns

//*****Here, elementpaths to specific neuron types can be set
if (type=="olm")
  cellp="/int_olm"
  compp="soma"
  total={N_olm}
elif (type=="b")
  cellp="/int_b"
  compp="soma"
  total={N_b}
elif (type=="msg")
  cellp="/int_msg"
  compp="soma"
  total={N_msg}
elif (type=="psoma")
  cellp="/pyr"
  compp="soma"
  total={N_pyr}
elif (type=="pak1")
  cellp="/pyr"
  compp="ak1"
  total={N_pyr}
elif (type=="pak3")
  cellp="/pyr"
  compp="ak3"
  total={N_pyr}
elif (type=="pak7")
  cellp="/pyr"
  compp="ak7"
  total={N_pyr}
elif (type=="pak10")
  cellp="/pyr"
  compp="ak10"
  total={N_pyr}
elif (type=="paik3")
  cellp="/pyr"
  compp="aik3"
  total={N_pyr}
elif (type=="padk3")
  cellp="/pyr"
  compp="adk3"
  total={N_pyr}
elif (type=="paik7")
  cellp="/pyr"
  compp="aik7"
  total={N_pyr}
elif (type=="padk7")
  cellp="/pyr"
  compp="adk7"
  total={N_pyr}
elif (type=="pas22c")
  cellp="/pyr"
  compp="as22c"
  total={N_pyr}
elif (type=="pas2")
  cellp="/pyr"
  compp="as2"
  total={N_pyr}
elif (type=="pas4c")
  cellp="/pyr"
  compp="as4c"
  total={N_pyr}
elif (type=="pak5")
  cellp="/pyr"
  compp="ak5"
  total={N_pyr}
elif (type=="paik6b")
  cellp="/pyr"
  compp="aik6b"
  total={N_pyr}
elif (type=="pat13b")
  cellp="/pyr"
  compp="at13b"
  total={N_pyr}
elif (type=="pas9b")
  cellp="/pyr"
  compp="as9b"
  total={N_pyr}
elif (type=="pas11a")
  cellp="/pyr"
  compp="as11a"
  total={N_pyr}
elif (type=="pas12a")
  cellp="/pyr"
  compp="as12a"
  total={N_pyr}
elif (type=="pas13a")
  cellp="/pyr"
  compp="as13a"
  total={N_pyr}
elif (type=="pas14a")
  cellp="/pyr"
  compp="as14a"
  total={N_pyr}
elif (type=="pac3b")
  cellp="/pyr"
  compp="ac3b"
  total={N_pyr}
elif (type=="paik3")
  cellp="/pyr"
  compp="aik3"
  total={N_pyr}
else
  echo "Misspecified NEURON_TYPE. Select from options int_olm, int_b or int_msg"
  return
end

//*****Tables for rasters
if (sr != 2)
  if (type=="b")
    res=80
  else
    res=20
  end
  for (i = 1; i<= {total}; i = i + 1)
    create table /spktrns/raster_{type}{i}
    setfield ^ step_mode 4 stepsize -0.01
    call ^ TABCREATE {time * res} 0 {time * res}
    addmsg {cellp}[{i}]/{compp} ^ INPUT Vm
    recs = {strcat {recs} " "}
    recs = {strcat {recs} raster_{type}{i}}
  end
end

//*****Tables for spike trains
if (sr != 1)
  i=1
  while(i<={no})
    if (!{exists /spktrns/sptr_{type}{i}})
      create table /spktrns/sptr_{type}{i}
      setfield ^ step_mode 3 
      useclock ^ 1
      call ^ TABCREATE {{time}/{dt2}} 0 {time}
      addmsg {cellp}[{i}]/{compp} /spktrns/sptr_{type}{i} INPUT Vm
      recs = {strcat {recs} " "}
      recs = {strcat {recs} sptr_{type}{i}}
      i=i+1
    end
  end
end

ce /

end

//*****An argumentless function for writing data on disk***********************

function spike_rec_save (sp)
str sp
int i
str tabname

mkdir {gp}{pp}{sp}

for (i = 1; i <= {getarg {arglist {recs}} -count}; i = i + 1)
  tabname = {getarg {arglist {recs}} -arg {i}}
  tab2file {gp}{pp}{sp}/{tabname}.dat \
	/spktrns/{tabname} \
	table
  delete /spktrns/{tabname}
end
recs = ""					//clearing record of records
if ({exists /output/extable[1]})
  tab2file {gp}{pp}{sp}/electrode.dat /output/extable[1] table
end
end
