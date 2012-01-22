%> @file reportD.m
%> @brief Saves detail and aggregate K-Means result information
%> @details Saves detail and aggregate K-Means result information including the parameters used, quality, run time, and actual K-Means iterations
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Saves detail and aggregate K-Means result information
%> @details Saves detail and aggregate K-Means result information including the parameters used, quality, run time, and actual K-Means iterations
% ======================================================================
classdef reportD

methods(Static)
	% ======================================================================
	%> @brief Takes a set of aggregate report rows and saves them to a file
	%> @details Takes a pre-generated set of aggregate report rows and saves them to a tab-delimited csv file
	%>
	%> @see ikmeans.entity.aggregateRR
	%> @param reportRows The list of rows to save
	%> @param fileName The destination file
	% ======================================================================
	function saveAggregateReport(reportRows,fileName)
		import ikmeans.data.*
		import ikmeans.entity.*

		rN = length(reportRows);

		fileId = fopen(fileName,'w');
		fprintf(fileId,'Data Source\tData Type\tInit Method\tSeed\tInit Time\tRun Time\tTotal Time\tIterations\tQuality Mean\tQuality Median\tQuality Minimum\tQuality Maximum\tQuality Standard Deviation\n');
		for ri=1:rN
			row = reportRows(ri);
			fprintf(fileId,'%s\t%s\t%s\t%9.0f\t%9.9f\t%9.9f\t%9.9f\t%9.0f\t%9.9f\t%9.9f\t%9.9f\t%9.9f\t%9.9f\n', ...
				row.sourceName, ...
				row.dataType, ...
				row.initType, ...
				row.seed, ...
				row.initTime, ...
				row.runTime, ...
				row.totalTime, ...
				row.iterations, ...
				row.qualityMean, ...
				row.qualityMedian, ...
				row.qualityMin, ...
				row.qualityMax, ...
				row.qualityStd );
		end % for
		fclose(fileId);
	end % function

	% ======================================================================
	%> @brief Takes a set of detail report rows and saves them to a file
	%> @details Takes a pre-generated set of detail report rows and saves them to a tab-delimited csv file
	%>
	%> @see ikmeans.entity.qualityRR
	%> @param reportRows The list of rows to save
	%> @param fileName The destination file
	% ======================================================================
	function saveQualityReport(reportRows,fileName)
		import ikmeans.data.*
		import ikmeans.entity.*

		rN = length(reportRows);

		fileId = fopen(fileName,'w');
		fprintf(fileId,'Data Source\tData Type\tInit Method\tSeed\tCluster #\tQuality\n');
		for ri=1:rN
			row = reportRows(ri);
			fprintf(fileId,'%s\t%s\t%s\t%9.0f\t%9.0f\t%9.9f\n', ...
				row.sourceName, ...
				row.dataType, ...
				row.initType, ...
				row.seed, ...
				row.clusterNumber, ...
				row.quality);
		end % for
		fclose(fileId);
	end % function

end % methods
end % classdef

