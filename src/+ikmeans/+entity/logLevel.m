%> @file logLevel.m
%> @brief The level at which to filter or display log entries
%> @details Describes the different levels of logging available between NONE and ALL. Each increase in level includes the logs from the previous levels
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief The level at which to filter or display log entries
%> @details Describes the different levels of logging available between NONE and ALL. Each increase in level includes the logs from the previous levels
% ======================================================================
classdef logLevel < uint32

properties (Constant)
	%> Report no logs
	NONE  = 0

	%> Report only critical application errors that cannot be recovered
	ERROR = 1

	%> Report application errors that can be recovered, but may result in unpredictable behavior
	WARN  = 2

	%> Report code issues that may become a problem in the future
	NOTICE= 3

	%> Report general progress information. 
	INFO  = 4

	%> Report more-detailed progress information
	DEBUG = 5

	%> Report the entering and exit of each function and its parameters
	TRACE = 6

	%> Report the contents of variables at different points, including within loops
	STEP  = 7

	%> Report all log entries
	ALL   = 8
end % properties

methods(Static)
	% ======================================================================
	%> @brief Converts the supplied logType into a string 
	%> @details Converts the supplied logType into a fixed-width string suitable for displaying within a log entry
	%>
	%> @param number The logLevel to convert
	%> @retval string The string that corresponds to the supplied logLevel
	% ======================================================================
	function string = toString(it)
		import ikmeans.entity.logLevel;
		switch it
			case logLevel.NONE
				string = 'NONE ';
			case logLevel.ERROR
				string = 'ERROR';
			case logLevel.WARN
				string = 'WARN ';
			case logLevel.NOTICE
				string = 'NOTCE';
			case logLevel.INFO
				string = 'INFO ';
			case logLevel.DEBUG
				string = 'DEBUG';
			case logLevel.TRACE
				string = 'TRACE';
			case logLevel.STEP
				string = 'STEP ';
			case logLevel.ALL
				string = 'ALL  ';
			otherwise
				string = '';
				error('Unexpected log level reported in logLevel.toString()');
		end % switch
	end % function
end % methods
end % classdef

