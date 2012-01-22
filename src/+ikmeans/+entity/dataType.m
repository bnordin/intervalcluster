%> @file dataType.m
%> @brief Represents the allowable data type containers for use in K-Means
%> @details Provides an enumeration of data types to represent the avalailable type containers. Provides a method for converting these types into a human-readable string
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Represents the allowable data type containers for use in K-Means
%> @details Provides an enumeration of data types to represent the avalailable type containers. Provides a method for converting these types into a human-readable string
% ======================================================================
classdef dataType < uint32

properties (Constant)
	%> Standard floating point numbers
	STANDARD = 1

	%> Interval numbers
	INTERVAL = 2

	%> Interval numbers whose radius has been artifically increased
	WIDEINTERVAL = 3
end % properties

methods(Static)
	% ======================================================================
	%> @brief Converts a dataType into a human-readable string
	%> @details Converts a dataType into a human-readable string
	%>
	%> @param number The dataType to convert
	%> @retval string The string representation of the specified dataType
	% ======================================================================
	function string = toString(dt)
		switch dt
			case ikmeans.entity.dataType.STANDARD
				string = 'Standard';
			case ikmeans.entity.dataType.INTERVAL
				string = 'Interval';
			case ikmeans.entity.dataType.WIDEINTERVAL
				string = 'WideInterval';
			otherwise
				string = '';
				warning('Unexpected data type reported in dataType.toString()');
		end % switch
	end % function
end % methods
end % classdef

