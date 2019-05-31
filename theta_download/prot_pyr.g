// genesis

include kons_pyr

if ((!{exists /library}))
    create neutral /library
    disable ^ 
end

ce /library

make_cylind_compartment
make_cylind_symcompartment

make_Na
make_K_DR
make_K_A
make_K_M
make_K_AHP
make_K_C
make_Ca
make_Ca_concI
make_Ca_concII
make_ECa_comp
make_I_H_S
make_I_H_D

ce /

readcell pyr2.p /prot_pyr

setup_ECa_comp

setfield /prot_pyr/# initVm -0.06686578748
