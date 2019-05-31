// genesis
// cell parameter file after P. Varona et al. Macroscopic and Subcellular Factors Shaping Population Spikes. J Neurophysiol 83:2192-2208, 2000
// and the homepage: http://navier.ucsd.edu/ca1ps/

// Hyperpolarization-activated current densities are from Jeffrey C. Magee: Dendritic Hyperpolarization-Activated Currents Modify the
// Integrative Properties of Hippocampal CA1 Pyramidal Neurons. Journal of Neuroscience 18: 7613-7624, 1998

//A useful command line:
//cat pyr.p | awk '{ OFS="\t" } { if ($8 > 0 && $8 <10) print $1,$2,$3,$4,$5,$6,$7,$8*10,$9" "$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23" "$24" "$25" "$26; else print $0 }' >p2

*polar
*relative
*asymmetric

*set_compt_param RM 7.0         // ohm*m^2
*set_compt_param RA 1.5         // ohm*m
*set_compt_param CM 0.0075      // F/m^2
*set_global EREST_ACT   -0.06686578748  // volts

*spherical

soma	none	0	0	0	17.5	I_H_S	10	Na 900	Ca	50	K_DR	48	K_AHP	9.0	K_A	600	K_M	37.5	K_C	1400	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 4.59         // ohm*m^2
*set_compt_param CM 0.01144      // F/m^2
*cylindrical

ak1	soma	22.4	0	180	3.5	I_H_D	10	Na 450	Ca	25	K_DR	24	K_AHP	4.5	K_A	300	K_M	18.75	K_C	1050	Ca_concI 7e-7 Ca_concII 2.4e-8
ak2	.	20	0	180	3.2	I_H_D	10	Na 450	Ca	25	K_DR	24	K_AHP	4.5	K_A	300	K_M	18.75	K_C	1050	Ca_concI 7e-7 Ca_concII 2.4e-8
ak3	.	55.5	0	180	3	I_H_D	20	Na 450	Ca	25	K_DR	24	K_AHP	4.5	K_A	300	K_M	18.75	K_C	1050	Ca_concI 7e-7 Ca_concII 2.4e-8
ak4	.	18.9	0	180	2.8	I_H_D	20	Na 300	Ca	16.6	K_DR	16	K_AHP	3.0	K_A	200	K_M	12.5	K_C	700	Ca_concI 7e-7 Ca_concII 2.4e-8
ak5	.	22.2	0	180	2.7	I_H_D	30	Na 300	Ca	16.6	K_DR	16	K_AHP	3.0	K_A	200	K_M	12.5	K_C	700	Ca_concI 7e-7 Ca_concII 2.4e-8
ak6	.	11.7	0	180	2.6	I_H_D	30	Na 300	Ca	16.6	K_DR	16	K_AHP	3.0	K_A	200	K_M	12.5	K_C	700	Ca_concI 7e-7 Ca_concII 2.4e-8
ak7	.	24.8	0	180	2.5	I_H_D	40	Na 300	Ca	16.6	K_DR	16	K_AHP	3.0	K_A	200	K_M	12.5	K_C	700	Ca_concI 7e-7 Ca_concII 2.4e-8
ak8	.	10.6	0	180	2.4	I_H_D	40	Na 200	Ca	11.1	K_DR	10.6	K_AHP	2.0	K_A	133	K_M	8.33	K_C	467	Ca_concI 7e-7 Ca_concII 2.4e-8
ak9	.	44	0	180	2.4	I_H_D	50	Na 200	Ca	11.1	K_DR	10.6	K_AHP	2.0	K_A	133	K_M	8.33	K_C	467	Ca_concI 7e-7 Ca_concII 2.4e-8
ak10	.	37.7	0	180	2.4	I_H_D	50	Na 200	Ca	11.1	K_DR	10.6	K_AHP	2.0	K_A	133	K_M	8.33	K_C	467	Ca_concI 7e-7 Ca_concII 2.4e-8
aik1	ak10	9.6	0	160	2	I_H_D	50	Na 200	Ca	11.1	K_DR	10.6	K_AHP	2.0	K_A	133	K_M	8.33	K_C	467	Ca_concI 7e-7 Ca_concII 2.4e-8
aik2	.	10.1	0	160	2	I_H_D	60	Na 200	Ca	11.1	K_DR	10.6	K_AHP	2.0	K_A	133	K_M	8.33	K_C	467	Ca_concI 7e-7 Ca_concII 2.4e-8
aik3	.	20.2	0	160	1.9	I_H_D	60	Na 100	Ca	5.56	K_DR	5.33	K_AHP	1.0	K_A	66.7	K_M	4.17	K_C	233	Ca_concI 7e-7 Ca_concII 2.4e-8
aik4	.	11.1	0	160	1.8	I_H_D	60	Na 100	Ca	5.56	K_DR	5.33	K_AHP	1.0	K_A	66.7	K_M	4.17	K_C	233	Ca_concI 7e-7 Ca_concII 2.4e-8
aik5	.	15.5	0	160	1.7	I_H_D	70	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
aik6a	.	47.2	0	160	1.6	I_H_D	70	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
aik6b	.	47.2	0	160	1.6	I_H_D	70	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
aik7	.	17.7	0	160	1.5	I_H_D	70	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
adk1	ak10	11.1	180	160	2	I_H_D	50	Na 200	Ca	11.1	K_DR	10.6	K_AHP	2.0	K_A	133	K_M	8.33	K_C	467	Ca_concI 7e-7 Ca_concII 2.4e-8
adk2	.	15.5	180	160	2	I_H_D	50	Na 200	Ca	11.1	K_DR	10.6	K_AHP	2.0	K_A	133	K_M	8.33	K_C	467	Ca_concI 7e-7 Ca_concII 2.4e-8
adk3	.	22.2	180	160	1.9	I_H_D	60	Na 100	Ca	5.56	K_DR	5.33	K_AHP	1.0	K_A	66.7	K_M	4.17	K_C	233	Ca_concI 7e-7 Ca_concII 2.4e-8
adk4	.	20	180	160	1.8	I_H_D	60	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
adk5a	.	43.3	180	160	1.7	I_H_D	60	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
adk5b	.	43.3	180	160	1.7	I_H_D	60	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
adk6	.	11.1	180	160	1.6	I_H_D	60	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
adk7	.	55.5	180	160	1.5	I_H_D	60	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 4.403         // ohm*m^2
*set_compt_param CM 0.01192      // F/m^2

as1	ak1	26.6	170	100	0.75	I_H_D	10	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as2	ak2	22.2	15	90	0.75	I_H_D	10	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as3a	ak3	54.4	45	100	0.75	I_H_D	20	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as3b	.	54.4	40	110	0.75	I_H_D	20	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as4a	ak4	63	140	105	0.75	I_H_D	20	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as4b	.	63	150	110	0.75	I_H_D	20	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as4c	.	63	150	130	0.75	I_H_D	30	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as5	ak5	17.7	215	115	0.75	I_H_D	30	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as6a	ak6	63.3	10	112	0.75	I_H_D	30	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as6b	.	63.3	0	125	0.75	I_H_D	40	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as7a	ak7	63.3	175	115	0.75	I_H_D	40	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as7b	.	63.3	180	125	0.75	I_H_D	40	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as8	ak8	17.7	100	120	0.75	I_H_D	40	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as9a	ak9	55	280	115	0.75	I_H_D	40	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as9b	.	55	270	128	0.75	I_H_D	50	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as9c	.	55	260	130	0.75	I_H_D	50	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as9d	.	55	240	135	0.75	I_H_D	50	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as10	aik1	22.2	80	90	0.75	I_H_D	50	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as11a	adk1	60	110	105	0.75	I_H_D	50	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as11b	.	60	125	115	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as12a	aik2	48.85	270	100	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as12b	.	48.85	260	115	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as13a	adk2	70.5	150	120	0.75	I_H_D	50	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as13b	.	70.5	130	125	0.75	I_H_D	50	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as14a	adk3	48.85	270	130	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as14b	.	48.85	260	150	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as15a	aik3	53.3	50	105	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as15b	.	53.3	40	120	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as16a	aik4	70	280	170	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as16b	.	70	300	175	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as17a	adk4	56.65	260	170	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as17b	.	56.65	240	180	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as18a	aik5	67.7	330	120	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as18b	.	67.7	350	130	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as19a	adk5b	40	135	115	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as19b	.	40	150	120	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as20	adk6	51.1	240	150	0.75	I_H_D	60	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as21a	aik6b	52.7	10	110	0.75	I_H_D	70	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as21b	.	52.7	20	120	0.75	I_H_D	70	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as22a	aik7	50	240	150	0.75	I_H_D	70	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as22b	.	50	250	148	0.75	I_H_D	80	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as22c	.	50	240	150	0.75	I_H_D	80	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as22d	.	50	260	160	0.75	I_H_D	80	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as23a	aik7	39.23	50	150	0.75	I_H_D	70	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as23b	.	39.23	60	153	0.75	I_H_D	80	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as23c	.	39.23	50	170	0.75	I_H_D	80	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as24a	adk7	38.5	90	150	0.75	I_H_D	70	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as24b	.	38.5	80	155	0.75	I_H_D	70	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as24c	.	38.5	75	170	0.75	I_H_D	80	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as25a	adk7	48.87	230	150	0.75	I_H_D	70	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as25b	.	48.87	245	170	0.75	I_H_D	70	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as25c	.	48.87	270	158	0.75	I_H_D	80	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
as25d	.	48.87	240	180	0.75	I_H_D	80	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at1	as1	60	140	80	0.75	I_H_D	10	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at2a	as1	42.2	220	115	0.75	I_H_D	10	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at2b	.	42.2	240	125	0.75	I_H_D	10	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at3	as2	28.8	300	120	0.75	I_H_D	10	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at4a	as2	52.6	30	95	0.75	I_H_D	10	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at4b	.	52.6	50	98	0.75	I_H_D	10	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at4c	.	52.6	70	102	0.75	I_H_D	10	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at5	as5	40.0	260	130	0.75	I_H_D	40	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at6a	as5	54.4	220	107	0.75	I_H_D	30	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at6b	.	54.4	180	110	0.75	I_H_D	30	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at6c	.	54.4	150	120	0.75	I_H_D	40	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at6d	.	54.4	130	125	0.75	I_H_D	40	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at7a	as8	55.2	120	105	0.75	I_H_D	40	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at7b	.	55.2	140	110	0.75	I_H_D	40	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at7c	.	55.2	120	115	0.75	I_H_D	50	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at8	as8	37.7	80	140	0.75	I_H_D	50	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at9a	as10	42.8	60	90	0.75	I_H_D	50	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at9b	.	42.8	65	100	0.75	I_H_D	50	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at10a	as10	64.4	100	100	0.75	I_H_D	50	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at10b	.	64.4	110	120	0.75	I_H_D	50	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 5.6         // ohm*m^2
*set_compt_param CM 0.00937      // F/m^2

at11a	as22d	46.7	230	155	0.75	I_H_D	80	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at11b	.	46.7	240	165	0.75	I_H_D	90	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at12	as22d	28.8	5	145	0.75	I_H_D	80	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at13a	as23c	74	30	160	0.75	I_H_D	80	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at13b	.	74	40	165	0.75	I_H_D	90	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at13c	.	74	70	170	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at14a	as23c	45.5	140	150	0.75	I_H_D	80	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at14b	.	45.5	160	160	0.75	I_H_D	90	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at15	as25d	82.22	320	140	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
at16	as25d	11.1	175	145	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 4.403         // ohm*m^2
*set_compt_param CM 0.01192      // F/m^2

ac1a	at3	57	0	97	0.75	I_H_D	10	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac1b	.	57	350	100	0.75	I_H_D	10	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac1c	.	57	320	110	0.75	I_H_D	10	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac2	at3	15.5	290	135	0.75	I_H_D	20	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac3a	at5	71.1	290	120	0.75	I_H_D	30	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac3b	.	71.1	300	140	0.75	I_H_D	50	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac4a	at5	69.4	230	110	0.75	I_H_D	30	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac4b	.	69.4	210	125	0.75	I_H_D	30	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac5a	at8	55.5	90	125	0.75	I_H_D	30	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac5b	.	55.5	100	120	0.75	I_H_D	40	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac6a	at8	48.9	70	110	0.75	I_H_D	30	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac6b	.	48.9	50	105	0.75	I_H_D	40	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac6c	.	48.9	80	110	0.75	I_H_D	40	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 5.6         // ohm*m^2
*set_compt_param CM 0.00937      // F/m^2

ac7	at12	22.2	310	140	0.75	I_H_D	90	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac8a	at12	44.4	40	150	0.75	I_H_D	90	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac8b	.	44.4	50	155	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac9a	at14b	71.1	60	165	0.75	I_H_D	90	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac9b	.	71.1	80	170	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac10	at14b	73.3	130	165	0.75	I_H_D	90	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac11	at15	57.7	20	160	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac12	at15	55.5	260	170	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac13	at16	17.7	230	160	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac14a	at16	52.2	120	140	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ac14b	.	52.2	130	150	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
aq1	ac2	68.8	260	150	0.75	I_H_D	20	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
aq2a	ac2	57.8	290	120	0.75	I_H_D	20	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
aq2b	.	57.8	280	125	0.75	I_H_D	20	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
aq3	ac7	86.6	260	170	0.75	I_H_D	90	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
aq4a	ac7	44.4	5	160	0.75	I_H_D	90	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
aq4b	.	44.4	15	170	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
aq5a	ac13	51.1	270	160	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
aq5b	.	51.1	280	155	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
aq6	ac13	28.8	170	150	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ax1a	aq3	74.4	300	150	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ax1b	.	74.4	10	165	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ax2a	aq3	51.1	220	170	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ax2b	.	51.1	210	160	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ax3	aq4b	31.1	290	160	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ax4	aq4b	80	60	160	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ax5	aq6	68.8	220	170	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
ax6	aq6	66.6	135	160	0.75	I_H_D	100	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 7.0         // ohm*m^2
*set_compt_param CM 0.0075      // F/m^2

bs1	soma	9.4	182	60	0.75	I_H_D	0.0	Na 300	Ca	16.6	K_DR	16	K_AHP	3.0	K_A	200	K_M	12.5	K_C	700	Ca_concI 7e-7 Ca_concII 2.4e-8
bs2	soma	9.6	2	60	0.75	I_H_D	0.0	Na 300	Ca	16.6	K_DR	16	K_AHP	3.0	K_A	200	K_M	12.5	K_C	700	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 4.59         // ohm*m^2
*set_compt_param CM 0.01144      // F/m^2

bt1a	bs1	36.4	110	82	0.75	I_H_D	0.0	Na 150	Ca	8.33	K_DR	8	K_AHP	1.5	K_A	100	K_M	6.25	K_C	350	Ca_concI 7e-7 Ca_concII 2.4e-8
bt1b	.	39.4	105	77	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bt2	bs1	6.7	225	10	0.75	I_H_D	0.0	Na 300	Ca	16.6	K_DR	16	K_AHP	3.0	K_A	200	K_M	12.5	K_C	700	Ca_concI 7e-7 Ca_concII 2.4e-8
bt3	bs2	40.5	70	30	0.75	I_H_D	0.0	Na 150	Ca	8.33	K_DR	8	K_AHP	1.5	K_A	100	K_M	6.25	K_C	350	Ca_concI 7e-7 Ca_concII 2.4e-8
bt4	bs2	11.2	315	80	0.75	I_H_D	0.0	Na 300	Ca	16.6	K_DR	16	K_AHP	3.0	K_A	200	K_M	12.5	K_C	700	Ca_concI 7e-7 Ca_concII 2.4e-8
bc1a	bt1b	69.4	60	80	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bc1b	.	69.4	20	70	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bc2	bt1b	39.3	130	65	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bc3	bt2	7.0	190	45	0.75	I_H_D	0.0	Na 300	Ca	16.6	K_DR	16	K_AHP	3.0	K_A	200	K_M	12.5	K_C	700	Ca_concI 7e-7 Ca_concII 2.4e-8
bc4	bt2	17.2	280	15	0.75	I_H_D	0.0	Na 150	Ca	8.33	K_DR	8	K_AHP	1.5	K_A	100	K_M	6.25	K_C	350	Ca_concI 7e-7 Ca_concII 2.4e-8
bc5a	bt3	70	100	25	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bc5b	.	70	105	20	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bc6a	bt3	39.2	80	35	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bc6b	.	39.2	85	30	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bc7	bt4	8.7	330	45	0.75	I_H_D	0.0	Na 300	Ca	16.6	K_DR	16	K_AHP	3.0	K_A	200	K_M	12.5	K_C	700	Ca_concI 7e-7 Ca_concII 2.4e-8
bc8	bt4	29.4	290	75	0.75	I_H_D	0.0	Na 150	Ca	8.33	K_DR	8	K_AHP	1.5	K_A	100	K_M	6.25	K_C	350	Ca_concI 7e-7 Ca_concII 2.4e-8
bq1a	bc2	50.1	90	62	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bq1b	.	50.1	70	55	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bq2	bc2	60.6	140	40	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bq3	bc3	27.3	130	75	0.75	I_H_D	0.0	Na 150	Ca	8.33	K_DR	8	K_AHP	1.5	K_A	100	K_M	6.25	K_C	350	Ca_concI 7e-7 Ca_concII 2.4e-8
bq4	bc3	10.5	230	10	0.75	I_H_D	0.0	Na 300	Ca	16.6	K_DR	16	K_AHP	3.0	K_A	200	K_M	12.5	K_C	700	Ca_concI 7e-7 Ca_concII 2.4e-8
bq5	bc4	11.9	310	20	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bq6a	bc4	48.15	230	35	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bq6b	.	48.15	260	30	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bq7a	bc7	39.6	80	42	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bq7b	.	39.5	70	38	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bq8	bc7	6.0	350	80	0.75	I_H_D	0.0	Na 150	Ca	8.33	K_DR	8	K_AHP	1.5	K_A	100	K_M	6.25	K_C	350	Ca_concI 7e-7 Ca_concII 2.4e-8
bq9a	bc8	58	300	70	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bq9b	.	58	310	65	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bq10	bc8	20.8	235	85	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bx1	bq3	44.7	120	70	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bx2a	bq3	47.1	150	60	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bx2b	.	47.1	165	55	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bx3	bq4	22.6	230	60	0.75	I_H_D	0.0	Na 150	Ca	8.33	K_DR	8	K_AHP	1.5	K_A	100	K_M	6.25	K_C	350	Ca_concI 7e-7 Ca_concII 2.4e-8
bx4	bq4	6.4	170	10	0.75	I_H_D	0.0	Na 150	Ca	8.33	K_DR	8	K_AHP	1.5	K_A	100	K_M	6.25	K_C	350	Ca_concI 7e-7 Ca_concII 2.4e-8
bx5	bq5	20.3	225	25	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bx6	bq5	21.0	280	5	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bx7a	bq7b	58.55	80	30	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bx7b	.	58.55	75	20	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bx8a	bq7b	55.85	40	50	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bx8b	.	55.85	45	40	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bx9a	bq8	56	35	55	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bx9b	.	56	30	50	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bx10	bq8	69.2	325	70	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bx11a	bq10	56.93	240	70	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bx11b	.	56.93	255	60	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bx11c	.	56.94	265	50	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bx12a	bq10	58	270	80	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bx12b	.	58	300	75	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bp1	bx1	50	125	70	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bp2	bx1	43	150	60	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bp3a	bx2b	44.3	200	60	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bp3b	.	44.3	230	50	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bp4	bx2b	24.5	140	40	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bp5	bx3	31.4	240	70	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bp6a	bx3	51.5	190	40	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bp6b	.	51.5	210	35	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bp7	bx4	36.4	150	35	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bp8	bx4	17.5	200	10	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bp9a	bx5	62.53	300	5	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bp9b	.	62.53	290	2	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bp9c	.	62.54	270	7	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bp10	bx5	6.8	240	30	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bp11a	bx6	54.33	340	5	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bp11b	.	54.33	310	15	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bp11c	.	54.34	300	10	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bp12a	bx6	51.7	280	30	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bp12b	.	51.7	250	25	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bp13a	bx10	52.5	40	45	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bp13b	.	52.5	30	40	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bp14a	bx10	40.8	290	60	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bp14b	.	40.8	310	55	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bo1a	bp5	69	250	55	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bo1b	.	69.1	265	45	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bo2	bp5	71.5	220	40	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bo3	bp6b	73	200	40	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bo4	bp6b	69.9	230	25	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bo5a	bp7	71.5	185	40	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bo5b	.	71.5	210	20	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bo6	bp7	19.3	140	20	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bo7a	bp8	63.63	180	20	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bo7b	.	63.63	185	17	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bo7c	.	63.64	195	15	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bo8	bp8	35	220	5	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bo9a	bp10	54.26	260	10	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bo9b	.	54.27	255	8	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bo9c	.	54.27	250	5	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bo10a	bp10	55.7	280	20	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bo10b	.	55.7	260	15	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bn1	bo2	52.2	230	40	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bn2	bo2	69.3	260	30	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bn3	bo6	61.7	170	30	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bn4a	bo6	41.05	150	20	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bn4b	.	41.05	160	15	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bn5a	bo8	51.23	190	22	0.75	I_H_D	0.0	Na 60	Ca	3.33	K_DR	3.2	K_AHP	0.6	K_A	40	K_M	2.5	K_C	140	Ca_concI 7e-7 Ca_concII 2.4e-8
bn5b	.	51.23	195	18	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bn5c	.	51.24	200	15	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8
bn6a	bo8	67.65	215	15	0.75	I_H_D	0.0	Na 40	Ca	2.22	K_DR	2.13	K_AHP	0.4	K_A	26.7	K_M	1.67	K_C	93	Ca_concI 7e-7 Ca_concII 2.4e-8
bn6b	.	67.65	190	10	0.75	I_H_D	0.0	Na 0	Ca	20	K_DR	5	K_AHP	5.4	K_A	0	K_M	1.67	K_C	20	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 7.0         // ohm*m^2
*set_compt_param RA 1.0         // ohm*m
*set_compt_param CM 0.0075      // F/m^2

AH	soma	20	0	20	1.75	I_H_D	0.0	Na 1800	Ca	100	K_DR	96	K_AHP	18	K_A	1200	K_M	75	K_C	2100	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 0.1         // ohm*m^2
*set_compt_param CM 0.0075      // F/m^2

isa	.	30	0	20	1	I_H_D	0.0	Na 2500	Ca	0	K_DR	1000	K_AHP	0	K_A	0	K_M	0	K_C	0	Ca_concI 7e-7 Ca_concII 2.4e-8
isb	.	30	0	17	1	I_H_D	0.0	Na 2500	Ca	0	K_DR	1000	K_AHP	0	K_A	0	K_M	0	K_C	0	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 50         // ohm*m^2
*set_compt_param CM 0.001      // F/m^2

m1a	.	75	0	13	1	I_H_D	0.0	Na 0	Ca	0	K_DR	0	K_AHP	0	K_A	0	K_M	0	K_C	0	Ca_concI 7e-7 Ca_concII 2.4e-8
m1b	.	75	0	17	1	I_H_D	0.0	Na 0	Ca	0	K_DR	0	K_AHP	0	K_A	0	K_M	0	K_C	0	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 0.1         // ohm*m^2
*set_compt_param CM 0.0075      // F/m^2

r1	.	20	0	15	2	I_H_D	0.0	Na 1000	Ca	0	K_DR	500	K_AHP	0	K_A	0	K_M	0	K_C	0	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 50         // ohm*m^2
*set_compt_param CM 0.001      // F/m^2

m2a	.	66.6	0	93	0.5	I_H_D	0.0	Na 0	Ca	0	K_DR	0	K_AHP	0	K_A	0	K_M	0	K_C	0	Ca_concI 7e-7 Ca_concII 2.4e-8
m2b	.	66.6	0	90	0.5	I_H_D	0.0	Na 0	Ca	0	K_DR	0	K_AHP	0	K_A	0	K_M	0	K_C	0	Ca_concI 7e-7 Ca_concII 2.4e-8
m2c	.	66.8	0	87	0.5	I_H_D	0.0	Na 0	Ca	0	K_DR	0	K_AHP	0	K_A	0	K_M	0	K_C	0	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 0.1         // ohm*m^2
*set_compt_param CM 0.0075      // F/m^2

r2	.	20	0	90	2	I_H_D	0.0	Na 0	Ca	0	K_DR	0	K_AHP	0	K_A	0	K_M	0	K_C	0	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 50         // ohm*m^2
*set_compt_param CM 0.001      // F/m^2

m3a	r1	100	180	90	1	I_H_D	0.0	Na 0	Ca	0	K_DR	0	K_AHP	0	K_A	0	K_M	0	K_C	0	Ca_concI 7e-7 Ca_concII 2.4e-8
m3b	.	100	180	85	1	I_H_D	0.0	Na 0	Ca	0	K_DR	0	K_AHP	0	K_A	0	K_M	0	K_C	0	Ca_concI 7e-7 Ca_concII 2.4e-8

*set_compt_param RM 0.1         // ohm*m^2
*set_compt_param CM 0.0075      // F/m^2

r3	.	20	180	90	2	I_H_D	0.0	Na 1000	Ca	0	K_DR	500	K_AHP	0	K_A	0	K_M	0	K_C	0	Ca_concI 7e-7 Ca_concII 2.4e-8
