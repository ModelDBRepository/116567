//genesis

function put_macro (num, comp, x0,y0,z0, xn,yn,zn, s)
int num         // number of electrodes
str comp        // compartments to be connected to the electrodes
                // use wildcards, like /pyr[]/a# -- all apical dendrites of all p. cells
float x0,y0,z0  // position of the first electrode, good defaults are:4e-4,0,1e-4
float xn,yn,zn  // position of the last electrode 4e-4,0,15e-4
                // immediate electrodes are placed linearly
int s           // if s>0 soma will be connected

str c_name
float dx,dy,dz
int i
    if (num < 1)
        return
    end

    dx=(xn-x0)/num
    dy=(yn-y0)/num
    dz=(zn-z0)/num

    echo "Setting up extracellular electrodes:"
    for (i = 1; i <={num}; i=i+1)
        echo "Electrode" {i} " ... " -nonewline
        create efield /electrode[{i}]
        setfield /electrode[{i}] scale -1e3 x {x0 + (i - 1) * dx} y {y0 + (i - 1) * dy} z {z0 + (i - 1) * dz}
        foreach c_name ({el {comp}[OBJECT=compartment]})
            addmsg {c_name} electrode[{i}] CURRENT Im 0.0
        end
        if (s > 0)
            foreach c_name ({el /pyr[]/soma})
                addmsg {c_name} electrode[{i}] CURRENT Im 0.0
            end
        end
        call electrode[{i}] RECALC
        echo "."
    end

    for (i=1; i<={num}; i=i+1)
        create table /output/extable[{i}]
        setfield ^ step_mode 3
        useclock ^ 1
        call ^ TABCREATE {{sim_time}/{dt2}} 0 {sim_time}
        addmsg /electrode[{i}] ^ INPUT field
    end
end
