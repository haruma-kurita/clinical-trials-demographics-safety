/* 1. Data Location */
libname mydata "/home/u64407940/portfolio_project/data";

/* 2. Nausea patients in ADAE and remove duplicates */
proc sort data=mydata.adae out=nausea_events (keep=USUBJID AEDECOD) nodupkey;
	by USUBJID;
	where upcase(AEDECOD)='NAUSEA';
run;

/* 3. Sort the master ADSL roster before merging */
proc sort data=mydata.adsl out=adsl_sorted;
	by USUBJID;
run;

/* 4. Merge the datasets to create analytical cohort */
data risk_analysis;
	/* 	merge by unique subject ID */
	merge adsl_sorted (in=in_adsl) nausea_events (in=in_ae);
	by USUBJID;
	/* 	Only keep patients who actually exist in the ADSL roster */
	if in_adsl;
	/* 	Filter to just Placebo and the High Dose drug arm */
	if TRT01P in ('Placebo', 'Xanomeline High Dose');
	/* 	Create the binary outcome variable (1 = Had Nausea, 0 = No Nausea) */
	if in_ae then Had_Nausea = 1;
	else Had_Nausea = 0;
run;

/* 5. Calculate the Relative Risk */
title "Relative Risk of Nausea: Xanomeline High Dose vs. Placebo";
proc freq data=risk_analysis;
	tables TRT01P * Had_Nausea / relrisk nocol nopercent;
run;
title;