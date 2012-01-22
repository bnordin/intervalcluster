%> @file qualityD.m
%> @brief Saves quality information to a file
%> @details Saves quality information to a file
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Saves quality information to a file
%> @details Saves quality information to a file
% ======================================================================
classdef qualityD

methods(Static)
	% ======================================================================
	%> @brief Saves quality information to a file
	%> @details Saves quality information to a file
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.quality
	%> @param r Experiment run information
	%> @param quality The quality information to save
	%> @param fileName The destination file to save the information
	%> @retval r Experiment run information
	% ======================================================================
	function r = save(r,quality, fileName)
		import ikmeans.entity.*
		
		dlmwrite(fileName, quality.values,'\t');
	end % function

end % methods
end % classdef

