%> @file centroidD.m
%> @brief Loads and saves centroid information to file
%> @details Loads and saves centroid information to file
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Loads and saves centroid information to file
%> @details Loads and saves centroid information to file
% ======================================================================
classdef centroidD

methods(Static)

	% ======================================================================
	%> @brief Load centroid information from file
	%> @details Load centroid information from file. Unimplemented method stub
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.centroidSet
	%> @param r Experiment run information
	%> @param fileName The name of the file to load
	%> @retval r Experiment run information
	%> @retval centroids The centroid information loaded from the file
	% ======================================================================
	function [r,centroids] = load(r,fileName)
		    import ikmeans.logic.logL
			import ikmeans.entity.*
			logt = logType.LOAD;
			
			r = logL.error(r,logt,'centroidD.load() not implemented!');
	end % function

	% ======================================================================
	%> @brief Saves centroid information to a file
	%> @details Saves centroid information to a file
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.centroidSet
	%> @param r Experiment run information
	%> @param centroidSet The centroid information to save
	%> @param fileName The destination file to save the information
	%> @retval r Experiment run information
	% ======================================================================
	function [r] = save(r,centroidSet,fileName)
	        import ikmeans.logic.logL
			import ikmeans.entity.*
			logt = logType.SAVE;
			
			switch centroidSet.type
    			case dataType.STANDARD
    				dlmwrite(fileName, centroidSet.values,'\t');
    			case dataType.INTERVAL
    				r = logL.error(r,logt,'centroidD.save() not implemented for intervals');
    			case dataType.WIDEINTERVAL
    				r = logL.error(r,logt,'centroidD.save() not implemented for intervals');
    			otherwise
    				r = logL.error(r,logt,sprintf('Unknown data type: %i',centroidSet.type));
		    end %switch
	end % function



end % methods	
end % classdef

