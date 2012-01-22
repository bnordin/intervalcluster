%> @file logWriter.m
%> @brief Contains the information necessary to write a log entry to the screen or a file
%> @details Contains information used to filter log entries and write them to the screen or file
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Contains the information necessary to write a log entry to the screen or a file
%> @details Contains information used to filter log entries and write them to the screen or file
% ======================================================================
classdef logWriter

properties
	%> A unique identifier for the writer
	id

	%> The type of log accepted by this writer
	%> @see ikmeans.entity.logType
	type

	%> The maximum level to write using this writer
	%> @see ikmeans.entity.logLevel
	level

	%> The MATLAB generated id for an opened log file. 0 if writing to the screen
	fileId

	%> The name of the file to write
	fileName
end % properties
end % classdef

