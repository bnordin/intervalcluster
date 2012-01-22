%> @file reportL.m
%> @brief Generate and save report information
%> @details Generate and save aggregate and detail reports
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Generate and save report information
%> @details Generate and save aggregate and detail reports
% ======================================================================
classdef reportL

methods(Static)

	% ======================================================================
	%> @brief Generates and saves the aggregate report
	%> @details Generates aggregate information across all clusters and saves as a tab-delimited CSV file at the given filename
	%>
	%> @see ikmeans.entity.run 
	%> @param runs Run information for all experiments represented in the report
	%> @param filename Destination file
	% ======================================================================
	function saveAggregateReport(runs,filename)
		import ikmeans.logic.*;
		import ikmeans.data.*;
		import ikmeans.entity.*;
		format('long');
		rN = length(runs);
		rows = aggregateRR.empty(0,0);
		for ri=1:rN
			run = runs(ri);
			[p,n,e] = fileparts(run.parameters.filename);
		
			row = aggregateRR();
			row.sourceName = strrep(n,' ', '_');
			row.dataType = dataType.toString(run.parameters.dataType);
			row.initType = initType.toString(run.parameters.initType);
			row.seed = run.parameters.randSeed;
			row.initTime = timeL.getTimingByType(run,logType.INIT).time;
			row.runTime = timeL.getTimingByType(run,logType.RUN).time;
			row.totalTime = timeL.getTimingByType(run,logType.ALL).time;
			row.iterations = run.results.actualIterations;
			row.qualityMean = mean(run.results.qualities.values);
			row.qualityMedian = median(run.results.qualities.values);
			row.qualityMin = min(run.results.qualities.values);
			row.qualityMax = max(run.results.qualities.values);
			row.qualityStd = std(run.results.qualities.values);
			rows(ri) = row;
		end %for ri
		
		reportD.saveAggregateReport(rows,filename);
		
	end % function

	% ======================================================================
	%> @brief Generates and saves the detail report
	%> @details Saves all information across all clusters and saves as a tab-delimited CSV file at the given filename
	%>
	%> @see ikmeans.entity.run 
	%> @param runs Run information for all experiments represented in the report
	%> @param filename Destination file
	% ======================================================================
	function saveQualityReport(runs,filename)
		import ikmeans.logic.*;
		import ikmeans.data.*;
		import ikmeans.entity.*;
		format('long');
		rN = length(runs);
		rows = qualityRR.empty(0,0);
		for ri=1:rN
			run = runs(ri);
			cN = run.parameters.nCentroids;
			[p,n,e] = fileparts(run.parameters.filename);
			for ci=1:cN
				row = qualityRR();
				row.sourceName = strrep(n,' ', '_');
				row.dataType = dataType.toString(run.parameters.dataType);
				row.initType = initType.toString(run.parameters.initType);
				row.seed = run.parameters.randSeed;
				row.clusterNumber = ci;
				row.quality = run.results.qualities.values(ci);
				rows(length(rows) + 1) = row;
			end %for
		end %for ri
		
		reportD.saveQualityReport(rows,filename);
		
	end % function

end % methods
end % classdef

