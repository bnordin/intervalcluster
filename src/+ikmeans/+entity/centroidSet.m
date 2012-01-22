%> @file centroidSet.m
%> @brief Contains the information needed to represent all of the centroids in K-Means
%> @details Holds generic information allowing multiple centroid snapshots. Holds specific centroid locations for all centroids in the experiment.
%> @author Ben Nordin
%> @date 09/01/2011
% ======================================================================
%> @brief Contains the information needed to represent all of the centroids in K-Means
%> @details Holds generic information allowing multiple centroid snapshots. Holds specific centroid locations for all centroids in the experiment.
% ======================================================================
classdef centroidSet

properties
	%> A unique numerical identifer for this set of centroids
	id

	%> The name of this centroid set. Contains parameter information to allow unique file name generation from this value.
	name

	%> The dataType of the centroids in this set.
	%> @see ikmeans.entity.dataType
	type

	%> The list of centroid locations in the centroids
	values
end % properties
end % classdef

