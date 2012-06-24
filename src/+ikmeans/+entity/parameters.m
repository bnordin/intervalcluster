%> @file parameters.m
%> @brief Contains the experiment parameters for a single K-Means run
%> @details Contains all the information necessary to set up, execute, and save the results for a K-Means run
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Contains the experiment parameters for a single K-Means run
%> @details Contains all the information necessary to set up, execute, and save the results for a K-Means run
% ======================================================================
classdef parameters

properties
	%> A unique identifier for this parameter set.
	id

	%> The name of the parameter set
	name

	%> The path of the source file and answer key
	sourcePath

	%> The path to save result files
	resultsPath

	%> The name of the source file including the extension
	filename

	%> The name of the source file without the extension
	basename

	%> The extension of the source file
	extension

	%> The membership file name
	membershipFile

	%> The number of centroids to use in K-Means
	nCentroids

	%> The number of blocks to use with Peak initialization. 
	%> 1 block will make Peak choose the same point for all centroids.
	%> nBlocks = number-of-points is the maximum and mimics Forgy-initialization
	nBlocks

	%> The random number seed for choosing between a set of centroids that is greater than the supplied nCentroids
	randSeed

	%> The number of times to loop through K-Means before forcing a stop
	iterations

	%> The minimum change allowed before K-Means stops
	epsilon

	%> The radius to use when widening centroids
	radius

	%> The dataType of the information read from the source file
	%> @see ikmeans.entity.dataType
	sourceType

	%> The target dataType for the information for execution with K-Means
	%> If dataType is different from sourceType, the data will be converted
	%> @see ikmeans.entity.dataType
	dataType

	%> The initialization method to use
	%> @see ikmeans.entity.initType
	initType

	%> The quality measure to use to measure the performance of the K-Means run
	%> @see ikmeans.entity.qualityType
	qualityType

	%> The set of log writers for recording log entries to files and/or the screen
	%> @see ikmeans.entity.logWriter
	writers
end % properties

methods
	% ======================================================================
	%> @brief Default cunstructor for ikmeans.entity.parameters
	%> @details Initializes default values and array containers for ikmeans.entity.parameters
	%>
	% ======================================================================
	function obj=parameters()
		import ikmeans.entity.*
		obj.writers = logWriter.empty(0,0);
		obj.membershipFile = '';
	end % function
end % methods
end % classdef

