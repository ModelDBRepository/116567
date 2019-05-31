// genesis

// Customized userprefs.g to run the "Traub91" simulation with neurokit

echo Using local user preferences

/**********************************************************************
**
**	1	Including script files for prototype functions
**
**********************************************************************/

include kons_pyr.g 

/**********************************************************************
**
**
**    	2	Invoking functions to make prototypes in the /library element
**
**********************************************************************/

/* To ensure that all subsequent elements are made in the library */

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
make_I_H_D
make_I_H_S

ce /

echo
echo
echo "****************************************************************"
echo "**                                                            **"
echo "**               !!!!!!!!!!!!!!!!!!!!!!                       **"
echo "**               ! DO NOT FOREGET TO !!                       **"
echo "**               !   setup_ECa_comp! !!                       **"
echo "**               !!!!!!!!!!!!!!!!!!!!!!                       **"
echo "**                                                            **"
echo "****************************************************************"
echo " "
echo "After the cellreader assembles the cell you'll have to"
echo "copy the ECa_comp object from the library below every"
echo "compartment. This is done by typing setup_ECa_comp"
echo " "
echo "Also don't mind the following error messages :-)"


/**********************************************************************
**
**	3	Setting preferences for user-variables.
**
**********************************************************************/
/* See defaults.g for default values of these */

// asymmetric -by pulin to incorporate asym compts
user_symcomps = 0
str user_help = "naplo.txt"

// wx, wy, cx, cy, cz for the draw widget
float user_wx = 0.45e-3
// 1.1e-3
float user_wy = 0.5e-3
float user_cx = 0.0
float user_cy = 0.1e-3
float user_cz = 0.1e-3
float user_wz = 0.1e-1

user_cell = "/prot_pyr"
user_pfile = "pyr.p"

user_runtime = 0.10
user_dt = 2.5e-6
user_refresh = 10

// default injection current (nA)
user_inject = 0.0

// Set the scales for the graphs in the two cell windows
user_ymin1 = -0.1
user_ymax1 = 0.15
user_xmax1 = 0.1
user_xmax2 = 0.1
user_ymin2 = 0.0
user_ymax2 = 5e-7
user_yoffset2 = 0.0

// user_colmax2 = 10000 this should keep it black, even if colfix doen't work
/*  This displays the second cell window and plots the "Gk" field of the
    "Ca" channel for the compartment in which a recording electrode
    has been planted.  The default values of the field and path
    are "Vm" and ".", meaning to plot the Vm field for the compartment
    which is selected for recording.
*/

user_numxouts = 1
user_field2 = "Gk"
user_path2 = "Ca"
