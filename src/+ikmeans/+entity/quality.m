%> @file quality.m
%> @brief Describes the structural similarty of points within each cluster
%> @details Describes the structural similarty of points within each cluster. Includes the correct count, totals, and quality % (correct/total)
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Describes the structural similarty of points within each cluster
%> @details Describes the structural similarty of points within each cluster. Includes the correct count, totals, and quality % (correct/total)
% ======================================================================
classdef quality

properties
	%> Unique identifier for this quality set
	id

	%> Name of this quality set
	name

	%> The calculated quality for each cluster
	values

	%> The number of correct points in each cluster
	correct

	%> The total number of points in each cluster
	totals
end % properties
end % classdef

