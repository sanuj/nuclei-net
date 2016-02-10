create_maps.m takes as input the xml file of the annotated image and returns a ternary map which serves as the training data for the CNNs. 

The ternary map has three classes - nucleus, non-culeus and the boundary (useful for separating overlapping or touching nuclei).

All the annotations have been done using Image Scope.

