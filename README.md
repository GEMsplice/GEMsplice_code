# GEMsplice_source_code
Matlab/Octave code of GEMsplice - Integrating splice-isoform expression into genome-scale models characterizes breast cancer metabolism

Please note this code has been tested with Matlab R2016b and Octave 4.0.3, with the GLPK solver.

If you use this code, please cite:
"C. Angione - Integrating splice-isoform expression into genome-scale models characterizes breast cancer metabolism, Bioinformatics, btx562, 2017"


--------------------
0. Initial settings
--------------------

Set the working directory in Matlab (or Octave) to the folder where the code is saved.
Then load the model 
>> load('fbabreast_trilevel.mat')

To get the list of metabolic reactions available, type
>> fbabreast.rxnNames

fbabreast.f selects the first objective (default: biomass)
fbabreast.g selects the second objective (default: pyruvate kinase)
fbabreast.h selects the third objective (default: lactate dehydrogenase)

To get the index of the current objective f, execute
>> ix_obj1 = find(fbabreast.f==1); 

To get the name of the reaction representing the current objective f, execute
>> fbabreast.rxnNames(ix_obj1)

To change the objective f to, e.g., acetate export, execute
>> ix_new_obj1 = find(ismember(fbabreast.rxns, 'EX_ac(e)')==1);
>> fbabreast.f(ix_obj1) = 0;
>> fbabreast.f(ix_new_obj1) = 1;



--------------------------------------------------------------------------------
1. Mapping Cancer RNA-Seq Nexus to the model and obtaining phenotype predictions
--------------------------------------------------------------------------------

Execute
>> GEMsplice_RNAseq

The profiles of 31 different cancer subsets will be automatically mapped onto the breast cancer model and the trilevel linear program will be solved for each of them.
This will generate a variable called "patients_results", containing flux rates and values of objective functions for each of the 31 cancer profiles. Please save this variable in a file called "patients_results.mat".

In each field of this variable, we will consider the first, second and fifth columns as they represent the three objectives as follows:
- biomass (1st component of the second output of evaluate_objective)
- pyruvate kinase (fmax, 2nd component of the second output of evaluate_objective)
- lactate dehydrogenase (fmax_min, 5th component of the second output of evaluate_objective)

The user can process custom data by saving them with the same structure used in the file "patients.mat". Although GEMsplice natively handles absolute expression values, it can also handle fold-change values directly, without logrithmic function. To enable this, please refer to the section named "Enable this section to handle fold-change expression data directly, without logarithmic map" in "evaluate_objective.m".


-------------------------
2. Flux control analysis
-------------------------

By default, the metabolic control analysis makes use of the parallel toolbox.
Before running the analysis, please make sure a parallel pool is open in Matlab/Octave. If a parallel pool is not available, please replace each "parfor"  with "for" and remove the instruction "addAttachedFiles(gcp,{'glpk.m','glpkcc'});" in the "metabolic_control_analysis.m" code.

To start the analysis, launch 
>> metabolic_control_analysis

Edit the variable delta if required (default = 0.001).
Please save the resulting variable "results_mca" in a file called e.g. "results_mca_eps0.001.mat".



------------------------------------------------------
3. Pathway-based flux analysis and generation of plots
------------------------------------------------------

Execute
>> plot_GEMsplice_RNAseq_cancer_vs_normal

and
>> plot_GEMsplice_RNAseq_invasive_vs_unlabeled

Please see comments in the code for details and parameters that can be adjusted as required (currently supported only in Matlab).



--------
License
--------

This is free software for academic use: you can redistribute it and/or modify it under the terms of the GNU Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This code is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Public License for more details.


Claudio Angione - July 2017
