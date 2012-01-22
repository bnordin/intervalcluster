%> @file membership.m
%> @brief Decribes what centroid each point is assigned to
%> @details Contains a list of centroid indicies that map each point to a centroid
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Decribes what centroid each point is assigned to
%> @details Contains a list of centroid indicies that map each point to a centroid
% ======================================================================
classdef membership

properties
	%> A unique identifier for this membership set. 
	%> Used for taking membership snapshots or loading alternate membership information
	id

	%> The name of this membership set.
	%> Used for human-readable identification and file naming
	name

	%> The list of centroid indicies for each data point
	values
end % properties
end % classdef

