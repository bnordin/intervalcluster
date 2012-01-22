%> @file timing.m
%> @brief Stores execution time information.
%> @details Stores the time in seconds spent between the tic and toc MATLAB calls
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Stores execution time information.
%> @details Stores the time in seconds spent between the tic and toc MATLAB calls
% ======================================================================
classdef timing

properties
	%> Unique identifier for this timing entry
	id

	%> The type of time information this entry represents
	%> @see ikmeans.entity.logType
	type

	%> The recorded time in seconds
	time
end % properties
end % classdef

