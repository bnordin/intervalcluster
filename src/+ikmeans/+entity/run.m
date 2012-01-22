%> @file run.m
%> @brief Holds all the information needed to execute a single experiment with K-Means
%> @details Holds the parameters, run-time data, and results for a K-Means experiment
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Holds all the information needed to execute a single experiment with K-Means
%> @details Holds the parameters, run-time data, and results for a K-Means experiment
% ======================================================================
classdef run

properties
	%> Unique identifier for this run
	id

	%> The name of the run
	name

	%> Contains the information needed to set up and execute the experiment
	%> @see ikmeans.entity.parameters
	parameters

	%> Holds the data used at run time during execution of K-Means
	%> @see ikmeans.entity.project
	project

	%> Holds the K-Means experiment result information
	%> @see ikmeans.entity.results
	results
end % properties

methods
	% ======================================================================
	%> @brief Default constructor for ikmeans.entity.run
	%> @details Default constructor for ikmeans.entity.run
	%>
	% ======================================================================
	function obj = run()
		import ikmeans.entity.*;
		obj.parameters = parameters();
		obj.project = project();
		obj.results = results();
	end % function
end % methods
end % classdef

