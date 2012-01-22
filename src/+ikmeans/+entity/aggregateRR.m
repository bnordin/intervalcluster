%> @file aggregateRR.m
%> @brief Represents one row of the aggregate report
%> @details Stores the data necessary to produce one row of the aggregate quality report
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Represents one row of the aggregate report
%> @details Stores the data necessary to produce one row of the aggregate quality report
% ======================================================================
classdef aggregateRR

properties
	%> The name of the source data set used in the run
	sourceName

	%> The name of the data container used in the experiment
	dataType

	%> The method used to choose initial centroids for K-Means
	initType

	%> The random number seed used during the centroid selection process
	seed

	%> The time spent executing the initialization algorithm
	initTime

	%> The time spent running K-Means
	runTime

	%> The time spent loading the source, initializing centroids, running K-Means, and saving the results
	totalTime

	%> The final number of iterations K-Means executed before the objective was reached and the algorithm stopped
	iterations

	%> The average quality of each cluster
	qualityMean

	%> The median quality for each cluster on this source
	qualityMedian

	%> The smallest cluster quality produced from this run
	qualityMin

	%> The largest cluster quality produced from this run
	qualityMax

	%> The variance between cluster qualities on this run
	qualityStd

end % properties
end % classdef

