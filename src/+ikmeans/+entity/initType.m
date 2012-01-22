%> @file initType.m
%> @brief An enumeration of available K-Means initialization methods
%> @details Provides a representation for K-Means initialization types and methods to convert them to strings.
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief An enumeration of available K-Means initialization methods
%> @details Provides a representation for K-Means initialization types and methods to convert them to strings.
% ======================================================================
classdef initType < uint32

properties (Constant)
	%> Load the centroid positions from a file. Not implemented
	LOAD = 0

	%> Use the result of another run to initialize this run. Not implemented
	RESULT = 1

	%> Choose centroids by randomly assigning points to different centroids. Not implemented
	RANDOM = 2

	%> Choose centroids by point concentration and some randomness
	PEAK = 3

	%> Take the highest quality clusters from other runs and use those for the centroid positions. Not implemented
	GREEDY = 4

	%> Randomly choose points in the data set to become the initial centroid positions
	FORGY = 5
end % properties

methods(Static)
	% ======================================================================
	%> @brief Converts the supplied initType into a string
	%> @details Converts the supplied initType into a human-readable string
	%>
	%> @param number The initType to convert
	%> @retval string The corresponding string for the supplied initType
	% ======================================================================
	function string = toString(it)
		switch it
			case ikmeans.entity.initType.LOAD
				string = 'Load';
			case ikmeans.entity.initType.RESULT
				string = 'Result';
			case ikmeans.entity.initType.RANDOM
				string = 'Random';
			case ikmeans.entity.initType.PEAK
				string = 'Peak';
			case ikmeans.entity.initType.GREEDY
				string = 'Greedy';
			case ikmeans.entity.initType.FORGY
				string = 'Forgy';
			otherwise
				string = '';
				warning('Unexpected init type reported in initType.toString()');
		end % switch
	end % function

	% ======================================================================
	%> @brief Converts the supplied initType into a fixed-width string
	%> @details Converts the supplied initType into a fixed-width, human-readable string
	%>
	%> @param number The initType to convert
	%> @retval string The corresponding fixed-width string for the supplied initType
	% ======================================================================
	function string = toFixedString(it)
		switch it
			case ikmeans.entity.initType.LOAD
				string = 'Load';
			case ikmeans.entity.initType.RESULT
				string = 'Rslt';
			case ikmeans.entity.initType.RANDOM
				string = 'Rand';
			case ikmeans.entity.initType.PEAK
				string = 'Peak';
			case ikmeans.entity.initType.GREEDY
				string = 'Grdy';
			case ikmeans.entity.initType.FORGY
				string = 'Forg';
			otherwise
				string = '';
				warning('Unexpected init type reported in initType.toString()');
		end % switch
	end % function

	% ======================================================================
	%> @brief Converts the supplied initType into a single character
	%> @details Converts the supplied initType into a character unique to that type
	%>
	%> @param number The initType to convert
	%> @retval string The corresponding character for the supplied initType
	% ======================================================================
	function char = toChar(it)
		switch it
			case ikmeans.entity.initType.LOAD
				char = 'L';
			case ikmeans.entity.initType.RESULT
				char = 'S';
			case ikmeans.entity.initType.RANDOM
				char = 'R';
			case ikmeans.entity.initType.PEAK
				char = 'P';
			case ikmeans.entity.initType.GREEDY
				char = 'G';
			case ikmeans.entity.initType.FORGY
				char = 'F';
			otherwise
				char = '';
				warning('Unexpected init type reported in initType.toString()');
		end % switch
	end % function

end % methods
end % classdef

