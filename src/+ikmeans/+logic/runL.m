%> @file runL.m
%> @brief Automates the execution of an experiment using the supplied parameters
%> @details Automates the execution of an experiment using the supplied parameters. Provides methods for executing a single run or batch of runs
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Automates the execution of an experiment using the supplied parameters
%> @details Automates the execution of an experiment using the supplied parameters. Provides methods for executing a single run or batch of runs
% ======================================================================
classdef runL

methods(Static)

	% ======================================================================
	%> @brief Automates the execution of a series of run based off of different combinations of parameters
	%> @details Automates the execution of a series of run based off of different combinations of parameters
	%>
	%> @see ikmeans.entity.batch
	%> @see ikmeans.entity.run
	%> @param batch The list of parameters combinations to use to generate runs
	%> @retval ret The results from each run
	% ======================================================================
	function runs = batch(batch)
		import ikmeans.logic.*;
		import ikmeans.entity.*;

		% gather data
		runN = length(batch.fnames);
		runs = ikmeans.entity.run.empty(0,0);
		fid = batch.fid;
		rands = batch.rands;

		p = batch.parameters;
		% loop through each source
		for id=1:runN
			% gather source information
			fname = char(batch.fnames(id));
			p.basename = fname;
			p.filename = strcat(fname,'.csv');
			p.membershipFile = char(batch.membershipFiles(id));
			p.resultsPath= char(batch.resultPaths(id));
			p.nCentroids = batch.centroidCounts(id);
			p.nBlocks = batch.blockCounts(id);

			% loop through each data type
			for dt = batch.dataTypes
				p.dataType = dt;
				% loop through each init type
				for it = batch.initTypes
					p.initType = it;
					% loop through each random seed
					for s=rands
						rid = length(runs)+1;
						p.randSeed = s; 
						
						% setup and open the log file
						if (fid > 0)
							p.writers(fid).fileName = strcat(p.resultsPath,filesep,lower(sprintf('%s_%s_%s_%s_%6.0f_log.txt', ...
								p.basename, ...
								dataType.toString(p.dataType), ...
								initType.toFixedString(p.initType), ...
								'final', ...
								p.randSeed)));
								%p.writers(fid).fileName
							p.writers(fid).fileId = fopen(p.writers(fid).fileName,'w'); % log after and generate file name
						end % if

						% execute the run
						runs(rid) = runL.run(p);
						runs(rid).id = rid;

						% close the log files
						if (fid > 0)
							fclose(runs(rid).parameters.writers(fid).fileId);
							runs(rid).parameters.writers(fid).fileId = -1;
							runs(rid).parameters.writers(fid).fileName = '';
						end % if
					end % for s
				end % for it
			end % for dt
		end % for id

	end % function

	% ======================================================================
	%> @brief Automates the execution of a single K-Means run
	%> @details Automates the execution of a single K-Means run based off of the supplied parameters
	%>
	%> @see ikmeans.entity.run
	%> @see ikemans.entity.parameters
	%> @param parameters The parameters used to setup and execute K-Means
	%> @retval r The collected experiment run information and results
	% ======================================================================
	function r = run(parameters)
		import ikmeans.logic.*;
		import ikmeans.entity.*;
		
		r = run();
		% save the parameters in the run object for easy access across the experiment
		r.parameters = parameters;

		% log the parameters	
		% todo: add validation step here
		logt = logType.RUN;
		r=logL.info(r,logt,sprintf('Parameter sourcePath     = %s'   ,r.parameters.sourcePath));
		r=logL.info(r,logt,sprintf('Parameter resultsPath    = %s'   ,r.parameters.resultsPath));
		r=logL.info(r,logt,sprintf('Parameter filename       = %s'   ,r.parameters.filename));
		r=logL.info(r,logt,sprintf('Parameter membershipFile = %s'   ,r.parameters.membershipFile));
		r=logL.info(r,logt,sprintf('Parameter nCentroids     = %9.0f',r.parameters.nCentroids));
		r=logL.info(r,logt,sprintf('Parameter nBlocks        = %9.0f',r.parameters.nBlocks));
		r=logL.info(r,logt,sprintf('Parameter randSeed       = %9.0f',r.parameters.randSeed));
		r=logL.info(r,logt,sprintf('Parameter iterations     = %9.0f',r.parameters.iterations));
		r=logL.info(r,logt,sprintf('Parameter epsilon        = %9.9f',r.parameters.epsilon));
		r=logL.info(r,logt,sprintf('Parameter radius         = %9.9f',r.parameters.radius));
		r=logL.info(r,logt,sprintf('Parameter sourceType     = %s'   ,dataType.toString(r.parameters.sourceType)));
		r=logL.info(r,logt,sprintf('Parameter dataType       = %s'   ,dataType.toString(r.parameters.dataType)));
		r=logL.info(r,logt,sprintf('Parameter initType       = %s'   ,initType.toString(r.parameters.initType)));
		r=logL.info(r,logt,sprintf('Parameter qualityType    = %s'   ,qualityType.toString(r.parameters.qualityType)));
		
		% load
		r = sourceL.load(r);
			
		% Convert source data type to target data type
		if (r.parameters.sourceType == dataType.STANDARD)
			switch r.parameters.dataType
				case dataType.STANDARD
				case dataType.INTERVAL
					r = sourceL.convertStandardToInterval(r);
				case dataType.WIDEINTERVAL
					r = sourceL.convertStandardToInterval(r);
				otherwise
					r = logL.error(r,logt,sprintf('Unknown data type: %i',r.parameters.dataType));
			end %switch
		end %if
		
		% initialize centroids
		r = centroidL.initCentroids(r);
		if (r.parameters.dataType == dataType.WIDEINTERVAL)
			r = centroidL.widenCentroids(r,r.parameters.radius);
		end % if
		
		% run K-Means
		r = kmeansL.run(r);
		
		% save centroids
		r = centroidL.save(r);
		
		% calculate quality
		r = qualityL.calculateQuality(r);
		
		% save quality
		r = qualityL.save(r,r.results.qualities);
		
		% save membership
		r = membershipL.save(r,r.project.members);
				
		% plot memberships
		r = membershipL.plot(r,r.project.members,r.project.centroids);
		
		logL.info(r,logType.RUN,'Run complete');
			
		% save timings
		timeL.save(r,logType.ALL);
		
		% save logs (no longer used since we save in real-time)
		%logL.save(r);

	end % function


    % ======================================================================
	%> @brief Validate the run parameters and stop if invalid
	%> @details Not implemented. Validate the run parameters and stop if invalid
	%>
	%> @see ikmeans.entity.run
	%> @param r Experiment run information
	%> @retval r Experiment run information
	% ======================================================================
	function r = validateParameters(r)
	end % function

end % methods
end % classdef

