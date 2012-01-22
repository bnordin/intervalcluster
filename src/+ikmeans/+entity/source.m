%> @file source.m
%> @brief Contains all the source file data in the proper format
%> @details Contains the source file data in different representations
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Contains all the source file data in the proper format
%> @details Contains the source file data in different representations
% ======================================================================
classdef source

properties
	%> Unique identifier for this source
	id

	%> Name of the source derived from the file name and parameters allowing unique result file names
	name

	%> The dataType of the source
	%> @see ikmeans.entity.dataType
	type

	%> The values in the proper dataType container
	values

	%> Same as values if using Standard data type. Contains the lower-bound values from the intervals if using interval data
	lowerValues

	%> Same as values if using Standard data type. Contains the upper-bound values from the intervals if using interval data
	upperValues

	%> Same as values if using Standard data type. Contains the midpoint values from the intervals if using interval data
	middleValues
end % properties
end % classdef

