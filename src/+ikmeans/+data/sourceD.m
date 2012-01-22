%> @file sourceD.m
%> @brief Loads source data from a file
%> @details Loads source data from a file
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Loads source data from a file
%> @details Loads source data from a file
% ======================================================================
classdef sourceD
	
methods (Static)
	% ======================================================================
	%> @brief Loads source data from a file
	%> @details Loads source data from a file
	%>
	%> @see ikmeans.entity.run
	%> @param r Experiment run information
	%> @param fileName The file containing the source data to load
	%> @retval r Experiment run information
	%> @retval data The loaded source data
	% ======================================================================
	function [r,data] = load(r,fileName)
		import ikmeans.logic.logL
			import ikmeans.entity.*
			logt = logType.LOAD;
			
			switch r.parameters.sourceType
    			case dataType.STANDARD
    				data = importdata(fileName);
    			case dataType.INTERVAL
    				r = logL.error(r,togt,'sourceD.load() not implemented for intervals');
    			case dataType.WIDEINTERVAL
    				r = logL.error(r,togt,'sourceD.load() not implemented for intervals');
    			otherwise
    				r = logL.error(r,logt,sprintf('Unknown data type: %i',r.parameters.sourceType));
		    end %switch
		
	end % function

end % methods
end % classdef

