%> @file timeL.m
%> @brief Tracks, converts, filters, and saves execution time information
%> @details Tracks, converts, filters, and saves execution time information
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Tracks, converts, filters, and saves execution time information
%> @details Tracks, converts, filters, and saves execution time information
% ======================================================================
classdef timeL
 
methods(Static)

	% ======================================================================
	%> @brief Starts a new timer and pushes it on the stack
	%> @details Starts a new timer and pushes it on the stack
	%>
	%> @see ikmeans.entity.run
	%> @param r Experiment run information
	%> @retval r Experiment run information
	% ======================================================================
	function r = startTime(r)
		r.project.timeIds(length(r.project.timeIds) + 1) = tic;
	end % function

	% ======================================================================
	%> @brief Pops a timer from the stack, stops the timer, and records the time
	%> @details Pops a timer from the stack, stops the timer, and stores the time in the project results
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.logType
	%> @param r Experiment run information
	%> @param type The type of time information recorded. Used for classification and filtering.
	%> @retval r Experiment run information
	% ======================================================================
	function r = endTime(r,type)
		import ikmeans.entity.*
		index = length(r.project.timeIds);

		time = timing();
		time.id = length(r.results.timings) + 1;
		time.type = type;
		time.time = toc(r.project.timeIds(index));
		r.results.timings(time.id) = time;
		r.project.timeIds(index) = [];
	end % function

	% ======================================================================
	%> @brief Save the project timing information to a file
	%> @details Save the project timing information to a file whose filename is generate from the experiment parameters
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.logType
	%> @param r Experiment run information
	%> @param type The type of timings to record. logType.ALL records every timing
	% ======================================================================
	function save(r,type)
		import ikmeans.logic.*;
		import ikmeans.data.*;
		import ikmeans.entity.*;

		fileName = strcat(r.parameters.resultsPath,filesep,lower(r.project.centroids.name),'_time.txt');
		timings = timing.empty(0,0);
		
		if (type == logType.ALL)
			for li=logType.GENERAL:logType.ALL
				t = timeL.getTimingByType(r,li);
				if (t.time > 0)
					timings(length(timings) + 1) = t;
				end %if
			end % for li
		else
			timings(1) = timeL.getTimingByType(r,type);
		end;
		
		timeD.save(r,timings,fileName);
		
	end % function
	
	% ======================================================================
	%> @brief Retrieve all of the experiment's recorded timing by type
	%> @details Retrieve all of the experiment's recorded timing by type
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.logType
	%> @param r Experiment run information
	%> @param type The type of timings to retrieve
	%> @retval t The total time recorded, in seconds, for the specified type
	% ======================================================================
	function t = getTimingByType(r,type)
		import ikmeans.entity.*;

		mN = length(r.results.timings);
		total=0;
		for i=1:mN
			timing = r.results.timings(i);
			if (timing.type == type || type == logType.ALL)
				total = total+timing.time;
			end % if
		end % for
		t = timing();
		t.type = type;
		t.time = total;
	end % function

end % methods
end % classdef

