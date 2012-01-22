%> @file timeD.m
%> @brief Saves recorded timing information to a file
%> @details Saves recorded timing information to a file
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Saves recorded timing information to a file
%> @details Saves recorded timing information to a file
% ======================================================================
classdef timeD

methods(Static)
	% ======================================================================
	%> @brief Saves recorded timing information to a file
	%> @details Saves recorded timing information to a file
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.timing
	%> @param r Experiment run information
	%> @param timings The recorded timing information
	%> @param fileName The destination file
	% ======================================================================
	function save(r,timings,fileName)
		import ikmeans.entity.*

		mN = length(timings);
		
		fileId = fopen(fileName,'w');
		for i=1:mN
			fprintf(fileId,'%s: %6.3f\n', logType.toString(timings(i).type), timings(i).time);
		end % for
		fclose(fileId);
		
	end % function
end % methods
end % classdef

