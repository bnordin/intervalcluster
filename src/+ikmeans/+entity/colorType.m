%> @file colorType.m
%> @brief Creates an enumeration of colors available to MATLAB
%> @details Provides a set of numerical constants for MATLAB colors. Provides a way to translate the numerical types to MATLAB color strings used in plots and figures.
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Creates an enumeration of colors available to MATLAB
%> @details Provides a set of numerical constants for MATLAB colors. Provides a way to translate the numerical types to MATLAB color strings
% ======================================================================
classdef colorType < int32

properties (Constant)
	%> The color black
	BLACK = 0

	%> The color blue
	BLUE = 1

	%> The color green
	GREEN = 2

	%> The color red
	RED = 3

	%> The color cyan
	CYAN = 4

	%> The color magenta
	MAGENTA = 5

	%> The color yellow
	YELLOW = 6

	%> The color white
	WHITE = 7
end % properties

methods(Static)
	% ======================================================================
	%> @brief Converts the numerical color type into a MATALB color character
	%> @details Converts the numerical color type into a MATALB color character
	%>
	%> @param number The color type to translate
	%> @retval char The MATLAB color character that corresponds to the specified type 
	% ======================================================================
	function char = toChar(it)
		import ikmeans.entity.colorType;
		switch it
			case colorType.BLACK
				char = 'k';
			case colorType.BLUE
				char = 'b';
			case colorType.GREEN
				char='g';
			case colorType.RED
				char='r';
			case colorType.CYAN
				char='c';
			case colorType.MAGENTA
				char='m';
			case colorType.YELLOW
				char='y';
			case colorType.WHITE
				char='w';
			otherwise
				char='';
				warning('Unexpected color type reported in colorType.toChar()');
		end % switch
	end % function
	
end % methods
end % classdef

