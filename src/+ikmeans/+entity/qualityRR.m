%> @file qualityRR.m
%> @brief Represents one line in the average quality report
%> @details Contains all the information necessary to display on line in the quality report
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Represents one line in the average quality report
%> @details Contains all the information necessary to display on line in the quality report
% ======================================================================
classdef qualityRR

properties
	%> The name of the source
	sourceName

	%> The data type container used in K-Means
	%> @see ikmeans.entity.dataType
	dataType

	%> The initialization type used for this run
	%> @see ikmeans.entity.initType
	initType

	%> The random number seed used for this run
	seed

	%> The specific cluster this quality measure represents
	clusterNumber

	%> The quality percentage for this cluster
	quality
end % properties
end % classdef
