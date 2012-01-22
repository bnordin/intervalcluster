%> @file logType.m
%> @brief Provides a set of types/categories for filtering log entries
%> @details Provides an enumeration of log types that describe the position in the algorithm the log entry was made. Provides a method to convert the representation to a string
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Provides a set of types/categories for filtering log entries
%> @details Provides an enumeration of log types that describe the position in the algorithm the log entry was made. Provides a method to convert the representation to a string
% ======================================================================
classdef logType < int32

properties (Constant)
	%> A log entry that doesn't fit into any category
	GENERAL = 0

	%> A log entry that occurs during the loading of data from files
	LOAD = 1

	%> A log entry that occurs when converting between data types
	CONVERT = 2

	%> A log entry that occurs when initializing K-Means centroids
	INIT = 3

	%> A log entry that occurs when running K-Means
	RUN = 4

	%> A log entry that occurs when calculating quality
	QUALITY = 5

	%> A log entry that occurs when saving the results to a file
	SAVE = 6

	%> A generic log entry that occurs in any ikmeans.logic.* class
	LOGIC = 7

	%> A generic log entry that occurs in any ikmeans.data.* class
	DATA = 8

	%> Used for filtering. Represents all log types
	ALL = 9
end % properties

methods(Static)
	% ======================================================================
	%> @brief Converts the supplied logType to a human-readable string
	%> @details Converts the supplied logType to a human-readable string
	%>
	%> @param int32 The logType to convert
	%> @retval string The corresponding string for the supplied log type
	% ======================================================================
	function string = toString(it)
		import ikmeans.entity.logType;
		switch it
			case logType.GENERAL
				string = 'General';
			case logType.LOAD
				string = 'Load';
			case logType.CONVERT
				string = 'Convert';
			case logType.INIT
				string = 'Init';
			case logType.RUN
				string = 'Run';
			case logType.QUALITY
				string = 'Quality';
			case logType.SAVE
				string = 'Save';
			case logType.LOGIC
				string = 'Logic';
			case logType.DATA
				string = 'Data';
			case logType.ALL
				string = 'All';
			otherwise
				string = '';
				warning('Unexpected log type reported in logType.toString()');
		end % switch
	end % function
end % methods
end % classdef

