The two scripts are used for post processing based on the nuclei map obtained as a result of the CNN.

separate_connected_components.m gives a different label to every separate nucleus based on the connected components algorithm.

watershed_output.m script applies the watershed algortithm on the distance transform obtained by the nuclei map obtained from the CNN.

