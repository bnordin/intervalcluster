%> @file logMessage.m
%> @brief Represents a single log entry
%> @details Contains all the information needed to filter and display a single log entry
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Represents a single log entry
%> @details Contains all the information needed to filter and display a single log entry
% ======================================================================
classdef logMessage

properties
	%> A unique identifier for the entry
	id

	%> The corresponding source. Not used
	sourceId

	%> The corresponding centroid set. Not used
	csetId

	%> The type (category) of log entry. Used for filtering
	%> @see ikmeans.entity.logType
	type

	%> The severity level of the log entry. Used for filtering
	%> @see ikmeans.entity.logLevel
	level

	%> The time the entry was created
	time

	%> The actual message that was supplied with this entry
	message
end % properties
end % classdef

