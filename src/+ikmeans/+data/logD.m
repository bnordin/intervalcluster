%> @file logD.m
%> @brief Reads or writes log information to the screen or file
%> @details Reads or writes log information to the screen or file
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Reads or writes log information to the screen or file
%> @details Reads or writes log information to the screen or file
% ======================================================================
classdef logD

methods(Static)

	% ======================================================================
	%> @brief Prints the supplied message to the indicated file
	%> @details Prints the supplied message to the indicated file. If the file is not specified or is -1, then the message is printed to the screen instead
	%>
	%> @see ikmeans.entity.logMessage
	%> @param message The message to print
	%> @param fileId The location to print to. Optional
	% ======================================================================
	function printLine(message,fileId)
		import ikmeans.entity.*
		
		m = sprintf('%s %s: %s\n', datestr(message.time,'mmm dd, yyyy HH:MM:SS.FFF'), logLevel.toString(message.level), message.message);
		if (exist('fileId') == 0)
			fileId = -1;
		end %if
		
		if (fileId == -1)
			fprintf('%s',m);
		else
			fprintf(fileId,'%s',m);
		end % if

	end % function

	% ======================================================================
	%> @brief Takes all log information for a run and saves it to the specified file in batch
	%> @details No longer used due to performance issues. Takes all log information for a run and saves it to the specified file in batch. Performs level and type filtering before writing the messages
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.logWriter
 	%> @param r Experiment run information
	%> @param writerId The index for the log writer that indicates the save destination
	% ======================================================================
	function save(r,writerId)
		import ikmeans.data.*
		import ikmeans.entity.*

		writer = r.parameters.writers(writerId);

		writer.fileId = fopen(writer.fileName,'w');
		mN = length(r.results.messages);
		for i=1:mN
			message = r.results.messages(i);
			if ((message.type == writer.type || writer.type == logType.ALL) ...
			  &&(message.level <= writer.level))

				logD.printLine(message,writer.fileId);
			end % if
		end % for
		fclose(writer.fileId);
	end % function

end % methods
end % classdef

