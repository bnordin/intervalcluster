%> @file batch.m
%> @brief Contains the information needed to execute multiple runs with different parameters
%> @details Holds the parameters in array form so a later process can loop over them and execute a run for each combination
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Contains the information needed to execute multiple runs with different parameters
%> @details Holds the parameters in array form so a later process can loop over them and execute a run for each combination
% ======================================================================
classdef batch

properties
	%> Batch identifier. Not currently used
	id

	%> Batch name. Not currently used
	name

	%> Holds parameters common to all batch runs such as paths, log settings, and fixed K-Means parameters
	parameters

	%> The file id for writing to a log file. A value of 0 prevents writing.
	fid

	%> A list of random number seeds to use
	rands

	%> A list of data types to use
	%> @see ikmeans.entity.dataType
	dataTypes

	%> A list of initialization types to use
	%> @see ikmeans.entity.initType
	initTypes

	%> A list of sources to use by name
	fnames

	%> A list of centroid counts corresponding to each source specified in fnames
	centroidCounts

	%> A list of block counts corresponding to each source specified in fnames
	blockCounts

	%> A list of files containing the answer key corresponding to each source specified in fnames
	membershipFiles

	%> A list of paths to output the results that corresponds to each source specified in fnames
	resultPaths
end % properties

methods
	% ======================================================================
	%> @brief Default constructor for the batch class
	%> @details Default constructor. Initializes objects, arrays, and cell arrays
	% ======================================================================
	function obj = batch()
		import ikmeans.entity.*;
		obj.parameters = parameters();
		obj.fnames = cell(0,0);
		obj.membershipFiles = cell(0,0);
		obj.resultPaths = cell(0,0);
	end % function
end % methods
end % classdef

