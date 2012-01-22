%> @file results.m
%> @brief Contains final result data produced from the K-Means algorithm
%> @details Provides timing, quality, and iteration information regarding a specific run
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Contains final result data produced from the K-Means algorithm
%> @details Provides timing, quality, and iteration information regarding a specific run
% ======================================================================
classdef results

properties
	%> A unique identifier for this result set
	id

	%> The name of this result set
	name

	%> Not used because of performance issues. Orignally used to store log messages
	%> @see logMessage
	messages

	%> A set of captured timing information related to this run
	%> @see ikmeans.entity.timing
	timings

	%> The actual number of iterations K-Means executed before it stopped
	actualIterations

	%> The list of quality information for each cluster on this run
	%> @see ikmeans.entity.quality
	qualities
end % properties

methods
	% ======================================================================
	%> @brief Default constructor for ikmeans.entity.results
	%> @details Default constructor for ikmeans.entity.results
	%>
	% ======================================================================
	function obj = results()
		import ikmeans.entity.*
		obj.messages = logMessage.empty(0,0);
		obj.timings = timing.empty(0,0);
	end % function
end % methods
end % classdef

