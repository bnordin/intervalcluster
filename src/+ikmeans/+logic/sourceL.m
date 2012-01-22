%> @file sourceL.m
%> @brief Load, Save, and Convert source file data
%> @details Load, Save, and Convert source file data
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Load, Save, and Convert source file data
%> @details Load, Save, and Convert source file data
% ======================================================================
classdef sourceL

methods (Static)

	% ======================================================================
	%> @brief Load the source file data
	%> @details Load the source file data from the file specified in the run parameters and store within the run parameters
	%>
	%> @see ikmeans.entity.run
	%> @param r Experiment run information
	%> @retval r Experiment run information
	% ======================================================================
	function r = load(r)
		import ikmeans.logic.*
		import ikmeans.data.*
		import ikmeans.entity.*
		
		logt = logType.LOAD;
		r = logL.trace(r,logt,'sourceL.load() start');
		r = timeL.startTime(r);
		
		source = source();
		
		% generate the filename and split into path/file components
		fullfile = strcat(r.parameters.sourcePath,r.parameters.filename);
		[p,n,e] = fileparts(fullfile);
		
		source.type = r.parameters.sourceType;
		source.name = upper(sprintf('%s_%s',strrep(n,' ', '_'),dataType.toString(source.type)));
		r.parameters.extension = e;

		% load the data
		r = logL.info(r,logt,sprintf('Loading source file: %s',r.parameters.filename));
		[r,source.values] = sourceD.load(r,fullfile);
		r.project.initialSource = source;
		r.project.source = source;

		r = timeL.endTime(r,logt);
		r = logL.trace(r,logt,'sourceL.load() complete');
	end % function
	
	% ======================================================================
	%> @brief Brief description of the exampleMethod2 method
	%> @details Long description
	%>
	%> @see ikmeans.entity.run
	%> @param r Experiment run information
	%> @retval r Experiment run information
	% ======================================================================
	function r = convertStandardToInterval(r)
		import ikmeans.logic.*
		import ikmeans.data.*
		import ikmeans.entity.*
		
		logt = logType.LOAD;
		r = logL.trace(r,logt,'sourceL.convertStandardToInterval() start');
		r = timeL.startTime(r);

		source = source();
		fullfile = strcat(r.parameters.sourcePath,r.parameters.filename);
		[p,n,e] = fileparts(fullfile);
		source.type = dataType.INTERVAL;
		source.name = upper(sprintf('%s_%s',strrep(n,' ', '_'),dataType.toString(source.type)));
		source.values = intval(r.project.initialSource.values);
		source.lowerValues = inf(source.values);
		source.upperValues = sup(source.values);
		source.middleValues = mid(source.values);

		r.project.source = source;
		r = logL.info(r,logt,sprintf('Converted %s to %s',r.project.initialSource.name,source.name));
		r = timeL.endTime(r,logt);
		r = logL.trace(r,logt,'sourceL.convertStandardToInterval() complete');
	end % function
	

	% ======================================================================
	%> @brief Reconstruct the complete filename from the experiment run parameters
	%> @details Reconstruct the complete filename from the experiment run parameters
	%>
	%> @see ikmeans.entity.run
	%> @param r Experiment run information
	%> @retval fn The filename including path information
	% ======================================================================
	function fn = getFileName(r)
		fn = strcat(r.parameters.sourcePath,filesep,r.parameters.filename);
	end % function

    	% ======================================================================
	%> @brief Converts the supplied value into the target data type
	%> @details Converts the supplied value into the target data type specified by the experiment's dataType parameter
	%>
	%> @see ikmeans.entity.run
	%> @param r Experiment run information
	%> @param data The value to convert
	%> @retval data The value converted into the target data type
	% ======================================================================
	function data = convertValue(r,data)
		import ikmeans.entity.dataType;
		switch r.parameters.dataType
			case dataType.INTERVAL
				data = intval(data);
			case dataType.WIDEINTERVAL
				data = intval(data);
		end %switch
	end % function

end % methods

end % classdef

