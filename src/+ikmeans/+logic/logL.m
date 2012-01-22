%> @file logL.m
%> @brief Logic used to filter and print log information to a file or the screen
%> @detail Logic used to filter and print log information to a file or the screen
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Logic used to filter and print log information to a file or the screen
%> @detail Logic used to filter and print log information to a file or the screen
% ======================================================================
classdef logL

methods(Static)

	% ======================================================================
	%> @brief Report an error message
	%> @details A simplified way to report an error message
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.logType
	%> @param r Experiment run information
	%> @param type The type of message to record. Used for filtering
	%> @param message The message string
	%> @retval r Experiment run information
	% ======================================================================
	function r = error(r,type,message)
		r = ikmeans.logic.logL.log( r, type, ikmeans.entity.logLevel.ERROR,message);
		warning(message);
		%error(message);
	end % function

	% ======================================================================
	%> @brief Report a warning message
	%> @details A simplified way to report a warning message
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.logType
	%> @param r Experiment run information
	%> @param type The type of message to record. Used for filtering
	%> @param message The message string
	%> @retval r Experiment run information
	% ======================================================================
	function r = warn(r,type,message)
		r = ikmeans.logic.logL.log( r, type, ikmeans.entity.logLevel.WARN,message);
		warning(message);
	end % function

	% ======================================================================
	%> @brief Report a notice message
	%> @details A simplified way to report a notice message
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.logType
	%> @param r Experiment run information
	%> @param type The type of message to record. Used for filtering
	%> @param message The message string
	%> @retval r Experiment run information
	% ======================================================================
	function r = notice(r,type,message)
		r = ikmeans.logic.logL.log( r, type, ikmeans.entity.logLevel.NOTICE,message);
	end % function

	% ======================================================================
	%> @brief Report an info message
	%> @details A simplified way to report an info message
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.logType
	%> @param r Experiment run information
	%> @param type The type of message to record. Used for filtering
	%> @param message The message string
	%> @retval r Experiment run information
	% ======================================================================
	function r = info(r,type,message)
		r = ikmeans.logic.logL.log( r, type, ikmeans.entity.logLevel.INFO,message);
	end % function

	% ======================================================================
	%> @brief Report a debug message
	%> @details A simplified way to report a debug message
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.logType
	%> @param r Experiment run information
	%> @param type The type of message to record. Used for filtering
	%> @param message The message string
	%> @retval r Experiment run information
	% ======================================================================
	function r = debug(r,type,message)
		r = ikmeans.logic.logL.log( r, type, ikmeans.entity.logLevel.DEBUG,message);
	end % function

	% ======================================================================
	%> @brief Report a trace message
	%> @details A simplified way to report a trace message
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.logType
	%> @param r Experiment run information
	%> @param type The type of message to record. Used for filtering
	%> @param message The message string
	%> @retval r Experiment run information
	% ======================================================================
	function r = trace(r,type,message)
		r = ikmeans.logic.logL.log( r, type, ikmeans.entity.logLevel.TRACE,message);
	end % function

	% ======================================================================
	%> @brief Report a step message
	%> @details A simplified way to report a step message
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.logType
	%> @param r Experiment run information
	%> @param type The type of message to record. Used for filtering
	%> @param message The message string
	%> @retval r Experiment run information
	% ======================================================================
	function r = step(r,type,message)
		r = ikmeans.logic.logL.log( r, type, ikmeans.entity.logLevel.STEP,message);
	end % function

	% ======================================================================
	%> @brief Log a message
	%> @details Log and filter a message to all available writers
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.logType
	%> @see ikmeans.entity.logLevel
	%> @param r Experiment run information
	%> @param type The type of message to record. Used for filtering
	%> @param level The severity level of the log message. Used for filtering
	%> @param message The message string
	%> @retval r Experiment run information
	% ======================================================================
	function r = log(r,type,level,message)
		import ikmeans.data.logD;
		import ikmeans.entity.*;
		m = logMessage();
		m.id = length(r.results.messages) + 1;
		m.type = type;
		m.level = level + 0;
		m.time = now;
		m.message = message;
		%r.results.messages(m.id) = m;

		wN = length(r.parameters.writers);
		for wi = 1:wN
			writer = r.parameters.writers(wi);
			if ((writer.type == type || writer.type == logType.ALL) ...
			&& writer.level >= level ...
			&& writer.fileId ~= 0)
				logD.printLine(m,writer.fileId);
			end %if
		end %for
	end % function

	% ======================================================================
	%> @brief Log a group of messages
	%> @details Log and filter a group of messages to the provided file
	%>
	%> @see ikmeans.entity.logType
	%> @see ikmeans.entity.logLevel
	%> @see ikmeans.entity.logMessage
	%> @param messages The list of messages to record
	%> @param type The type of message to record. Filters the provided messages before recording
	%> @param level The severity level of the log message to record. Filters the provided messages before recording
	%> @param fileId The destination file. -1 indicates writing to the screen
	% ======================================================================
	function print(messages,type,level,fileId)
		import ikmeans.data.logD;
		mN = length(messages);
		for i=1:mN
			if (messages(i).type == type)
				logD.printLine(messages(i),level,fileId);
			end % if
		end % for
	end % function

	% ======================================================================
	%> @brief Save the currently stored log messages to all the log writers
	%> @details No longer used because of performance issues. Save the currently stored log messages to all the log writers.
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.logWriter
	%> @param r Experiment run information
	%> @param writer Not used
	% ======================================================================
	function save(r,writer)
		import ikmeans.data.logD;
		source = r.project.source;
		fileName = strcat(r.parameters.resultsPath,filesep,lower(r.project.centroids.name),'_log.txt');
		
		wN = length(r.parameters.writers);
		for i=1:wN
			if (r.parameters.writers(i).fileId == 0)
				r.parameters.writers(i).fileName = fileName;
				logD.save(r,i);
			end %if
		end %for
		
		
	end % function

end % methods
	
end % classdef

