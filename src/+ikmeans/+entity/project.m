%> @file project.m
%> @brief Contains run-time data for use with the K-Means algorithm
%> @details Stores all of the data, centroid, membership, and timing information used during the execution of K-Means
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Contains run-time data for use with the K-Means algorithm
%> @details Stores all of the data, centroid, membership, and timing information used during the execution of K-Means
% ======================================================================
classdef project

properties
	%> The source data as it was read from the file
	%> @see ikmeans.entity.source
	initialSource

	%> The source data after the data type conversion
	%> @see ikmeans.entity.source
	source

	%> The centroids chosen by the initialization method
	%> @see ikmeans.entity.centroidSet
	initialCentroids

	%> The final centroids positioned by K-Means
	%> @see ikmeans.entity.centroidSet
	centroids

	%> The association between points and centroids provided by K-Means
	%> @see ikmeans.entity.membership
	members

	%> The answer key for point-centroid association loaded from a data file
	%> @see ikmeans.entity.membership
	loadedMembers

	%> Maps the indicies between members and loadedMembers
	memberMappings

	%> A list of time indcies for use with MATLABs tic and toc functions
	timeIds
end % properties

methods
	% ======================================================================
	%> @brief Default constructor for ikmeans.entity.project
	%> @details Default constructor for ikmeans.entity.project
	%>
	% ======================================================================
	function p = project()
%		import ikmeans.entity.*
		p.timeIds = uint64.empty(0,0);
	end % function

end % methods
end % classdef

