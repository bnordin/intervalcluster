%> @file qualityType.m
%> @brief The structural similarity measure to use in the experiment
%> @details Contains an enumeration of the different structual similarity measures available to the experiment. Provides a method to translate the representation to a string.
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief The structural similarity measure to use in the experiment
%> @details Contains an enumeration of the different structual similarity measures available to the experiment. Provides a method to translate the representation to a string.
% ======================================================================
classdef qualityType < int32

properties (Constant)
	%> Jaccard Index quality measure. Compares the results with an answer key
	JACCARD = 0
end % properties

methods(Static)
	% ======================================================================
	%> @brief Returns a string representation of the supplied qualityType
	%> @details Returns a string representation of the supplied qualityType
	%>
	%> @param int32 The qualityType to convert into a string
	%> @retval string The corresponding string representation for the supplied qualityType
	% ======================================================================
	function string = toString(it)
		import ikmeans.entity.qualityType;
		switch it
			case qualityType.JACCARD
				string = 'Jaccard Index';
			otherwise
				string = '';
				error('Unexpected quality type reported in qualityType.toString()');
		end % switch
	end % function
end % methods
end % classdef
