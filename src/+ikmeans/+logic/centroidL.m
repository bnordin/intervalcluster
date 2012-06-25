%> @file centroidL.m
%> @brief Contains the logic necessary to select an initial set of centroids
%> @details Provides different K-Means initial centroid selection methods including: Forgy and Peak
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Contains the logic necessary to select an initial set of centroids
%> @details Provides different K-Means initial centroid selection methods including: Forgy and Peak
% ======================================================================
classdef centroidL

methods(Static)

	% ======================================================================
	%> @brief Takes the initType run parameter and calls the appropriate initialization method
	%> @details Takes the initType run parameter and calls the appropriate initialization method
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.initType
	%> @param r Experiment run information
	%> @retval r Experiment run information
	% ======================================================================
	function r = initCentroids(r)
		import ikmeans.logic.*;
		import ikmeans.entity.*;
		switch r.parameters.initType
			case initType.FORGY
				r = centroidL.forgyCentroids(r);
			case initType.PEAK
				r = centroidL.peakCentroids(r);
			otherwise
				r = logL.error(r,sprintf('Unknown init type: %i',r.parameters.initType));
		end %switch
	end % function

	% ======================================================================
	%> @brief Selects centroids using the Peak initialization method
	%> @details Selects centroids using the Peak initialization method, which chooses centroids based on point location frequency
	%>
	%> @see ikmeans.entity.run
	%> @param r Experiment run information
	%> @retval r Experiment run information
	% ======================================================================
	function r = peakCentroids(r)
		% Setup types, logging, and timing
		import ikmeans.logic.*
		import ikmeans.entity.*;
		logt = logType.INIT;
		r = logL.trace(r,logt,'centroidL.peakCentroids()');
		r = logL.info(r,logt,sprintf('Generating initial centroids for %s',r.project.source.name));
		r = timeL.startTime(r);
		
		% Get default centroid containers
		r.project.initialCentroids = centroidL.getCentroidSet(r,1);
		r.project.centroids = centroidL.getCentroidSet(r,0);
		rand('seed',r.parameters.randSeed);

		% Gather information
		source = r.project.source;
		data = source.values;
		[nPoints,nDim] = size(data);
		nCluster = r.parameters.nCentroids;
		psize=zeros(nDim,1);
		maxPsize=0;
		nCombos=1;

		% Find point frequency peaks		
		for d = 1:nDim
			[r,peak]=centroidL.getCountPeaks(r,d);
			[newDim,newSize] = size(peak);
			psize(d)=newSize;
			maxPsize=max(maxPsize,newSize);
		end %for d
		nCombos = maxPsize^nDim;
		peaks=sourceL.convertValue(r,zeros(maxPsize,nDim))*NaN;

		for d = 1:nDim
			[r,peak]=centroidL.getCountPeaks(r,d);
			for p = 1:psize(d)
				peaks(p,d) = peak(p);
			end %for p
		end %for d
%peaks
%disp('peaks:'); disp(peaks); disp(' ');
%disp('psize:'); disp(psize); disp(' ');

		% Find all combinations of peaks and generate a set of possible centroids
		combos = sourceL.convertValue(r,zeros(nCombos,nDim) * NaN);
		newCombos = sourceL.convertValue(r,zeros(nCombos,nDim) * NaN);
		centroids = sourceL.convertValue(r,zeros(nCluster, nDim));
		
		for c=1:nCombos
			valid=true;
			for d= 1:nDim
				if (valid == true)
%peaks(mod(c*d,maxPsize) + 1,d)
					combos(c,d) = peaks(mod(c*d,maxPsize) + 1,d);
					if (isnan(combos(c,d)) == 1)
						valid=false;
					end %if
				end %if 
			end %for d
		end %for c
%combos
		% remove duplicates
		for c1=1:nCombos
			found=false;
			for c2=c1+1:nCombos
				sameCount=0;
				for di=1:nDim
					if (combos(c1,di) == combos(c2,di))
						sameCount = sameCount + 1;
					end %if
				end % for d
				if (sameCount == nDim)
					found=true;
					break;
				end %if
			end % for c2
			if (found == false)
				newCombos(c1,:) = combos(c1,:);
			end %if
		end % for c1
		combos = newCombos;
		combos(any(isnan(combos),2),:) = []; % remove NaN rows
%combos
		[nCombos,trash] = size(combos);
		
		% generate a random index order for the generated centroids
		clist = 1:nCombos;
		if (nCombos > nCluster)
			clist = randperm(nCombos);
		end %if
		
		if (nCombos < nCluster)
			clist = randperm(nCombos*3);
			%clist = clist + nCombos;
			%clist = cat(2,1:nCombos,clist);
warning('try increasing blocks');
		end %if

		% select the centroids from the combos based on the random index
		count=0;
		for c= 1:nCluster
			if (clist(c) <= nCombos)
				
					centroids(c,:) = combos(clist(c),:);
				
			else
				if (mod(clist(c),(nCombos*2)) == 1)% add to the current point
					centroids(c,:) = combos(mod(clist(c),nCombos)+1,:) + combos(mod(clist(c),nCombos)+1,:) / 5;
				else % subtract from the current point
					centroids(c,:) = combos(mod(clist(c),nCombos)+1,:) - combos(mod(clist(c),nCombos)+1,:) / 5;
				end %if
			end %if
		end %for c
%centroids
		% Save the initial centroids
		r.project.initialCentroids.values = centroids;
		r.project.centroids.values = centroids;
		
		r = timeL.endTime(r,logt);
		r = logL.trace(r,logt,'centroidL.peakCentroids() complete');
	end % function

	% ======================================================================
	%> @brief Choose intial centroids based off of the Random method
	%> @details Not implemented. Choose initial centroids by randomly assigning points to centroids, then averageing the centroid members' coordinates
	%>
	%> @see ikmeans.entity.run
	%> @param r Experiment run information
	%> @retval r Experiment run information
	% ======================================================================
	function r = randomCentroids(r)
		import ikmeans.logic.*
		import ikmeans.entity.*

		logt = logType.INIT;
		r = logL.trace(r,logt,'centroidL.randomCentroids()');
		r = logL.info(r,logt,sprintf('Generating initial centroids for %s',r.project.source.name));
		r = timeL.startTime(r);
		rand('seed',r.parameters.randSeed);

		r.project.initialCentroids = centroidL.getCentroidSet(r,1);
		r.project.centroids = centroidL.getCentroidSet(r,0);
		source = r.project.source;
		data = source.values;
		[nPoints,nDim] = size(data);
		centroids = zeros(nCluster, nDim);
		plist = randperm(nPoints);
		
		for c = 1:nCluster
			psum = zeros(1, nDim);
			pcount = 0;
			for p = 1:nPoints
				if (mod(p,nCluster) == c)
					psum = psum + data(plist(p),:);
					pcount = pcount+1;
				end
			end % for p
			centroids(c,:) = psum / pcount;
		end %for c

		r.project.intialCentroids.values = centroids;
		r.project.centroids.values = centroids;
		r = timeL.endTime(r,logt);
		r = logL.trace(r,logt,'centroidL.randomCentroids() complete');
	end % function

	% ======================================================================
	%> @brief Chooses an initial set of centroids using the Forgy method
	%> @details Chooses an initial set of centroids by randomly choosing points from the data set as the centroids
	%>
	%> @see ikmeans.entity.run
	%> @param r Experiment run information
	%> @retval r Experiment run information
	% ======================================================================
	function r = forgyCentroids(r)
		import ikmeans.logic.*
		import ikmeans.entity.*
		
		% setup log and timing
		logt = logType.INIT;
		r = logL.trace(r,logt,'centroidL.forgyCentroids()');
		r = logL.info(r,logt,sprintf('Generating initial centroids for %s',r.project.source.name));
		r = timeL.startTime(r);
		rand('seed',r.parameters.randSeed);

		% get centroid containers and gather data
		r.project.initialCentroids = centroidL.getCentroidSet(r,1);
		r.project.centroids = centroidL.getCentroidSet(r,0);
		source = r.project.source;
		data = source.values;
		[nPoints,nDim] = size(data);
		nCluster = r.parameters.nCentroids;
		
		centroids = sourceL.convertValue(r,zeros(nCluster, nDim));
		
		% generate a random list of point indicies
		plist = randperm(nPoints);
		% get the point from the random index and save it as a centroid
		for c = 1:nCluster
			centroids(c,:) = data(plist(c),:);
		end %for c

		% save the centroids
		r.project.initialCentroids.values = centroids;
		r.project.centroids.values = centroids;
		r = timeL.endTime(r,logt);
		r = logL.trace(r,logt,'centroidL.forgyCentroids() complete');
	end % function

	% ======================================================================
	%> @brief Prepares the centroid information and saves it to a file
	%> @details Saves the centroid inforamtion to a file and records logging and timing information
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.data.centroidD
	%> @param r Experiment run information
	%> @retval r Experiment run information
	% ======================================================================
	function r = save(r)
		import ikmeans.logic.*
		import ikmeans.data.*
		import ikmeans.entity.*
		
		logt = logType.SAVE;
		r = logL.trace(r,logt,'centroidL.save()');

		% get the file name
		fn = strcat(r.parameters.resultsPath,filesep,lower(r.project.centroids.name),'_cluster',r.parameters.extension);
		r = logL.info(r,logt,sprintf('Saving centroids to: %s',fn));
		r = timeL.startTime(r);

		% save the centroids
		r = centroidD.save(r,r.project.centroids,fn);

		r = timeL.endTime(r,logt);
		r = logL.trace(r,logt,'centroidL.save() complete');
	end % function

	% ======================================================================
	%> @brief Returns the local maxima for a single dimension of data
	%> @details Divides a single dimension of data into equal segments based off of the nBlocks parameter, counts the values in each segment, and returns the local maxima of the segment/count positions
	%>
	%> @see ikmeans.entity.run
	%> @param r Experiment run information
	%> @param d The data to use in finding the local maxima
	%> @retval r Experiment run information
	%> @retval peaks The local maxima of the supplied data
	% ======================================================================
	function [r,peaks] = getCountPeaks(r,d)
		import ikmeans.logic.*
		import ikmeans.entity.*
		
		% get lower-bound and upper-bound data based on data type
		switch r.parameters.dataType
			case dataType.STANDARD
				minData=r.project.source.values(:,d);
				maxData=minData;
			case dataType.INTERVAL
				minData = r.project.source.lowerValues(:,d);
		        maxData = r.project.source.upperValues(:,d);
			case dataType.WIDEINTERVAL
				minData = r.project.source.lowerValues(:,d);
		        maxData = r.project.source.upperValues(:,d);
		end %switch
		
		% Gather information
		minValue = min(minData);
		maxValue = max(maxData);
		
		nBlocks = r.parameters.nBlocks;
		[n,dim] = size(minData);

		r = logL.trace(r,logType.INIT,sprintf('Getting peaks from %d blocks for %d rows and %d columns',nBlocks,n,dim));

		blockSize = (maxValue-minValue)/nBlocks;
		valCount = zeros(nBlocks+1,1);

		% Count point frequency in each divided segment
		for di=1:n
		    for bi=1:nBlocks
%fprintf('di: %d	Index: %d\n',di,floor(data(di)/blockSize) + 1);
%			valCount(floor((data(di)-minValue)/blockSize) + 1) = 1 + valCount(floor((data(di)-minValue)/blockSize) + 1);
                if (kmeansL.iManDistance(minData(di),maxData(di),(bi-1)*blockSize + minValue,bi*blockSize + minValue) == 0)
					valCount(bi) = 1 + valCount(bi);
				end %if
			end % for bi
		end % for di
%valCount
% This is the original method, but it required the signal processing toolbox.
%		[pks,locs] = findpeaks(valCount);


		% Using this method instead to eliminate that dependency
		% Find the local maxima
		[pks,locs,trash,trash] = extrema(valCount);
		pks = pks';
		locs = locs';

		% Convert and save the resulting peaks
		peaks = sourceL.convertValue(r,locs*blockSize + minValue);

	end % function

	% ======================================================================
	%> @brief Gets a default centroid set container
	%> @details Gets a default centroid set container
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.centroidSet
	%> @param r Experiment run information
	%> @param initial Identifies this centroid set as the initialally selected centroids, or the ones moved by K-Means
	%> @retval cset The new centroidSet
	% ======================================================================
	function cset = getCentroidSet(r,initial)
		import ikmeans.entity.*
		if (initial == 1)
			fs = 'INITL';
		else
			fs = 'FINAL';
		end % if

		cset = centroidSet();
		cset.name = upper(sprintf('%s_%s_%s_%6.0f', ...
						r.project.source.name, ...
						initType.toFixedString(r.parameters.initType), ...
						fs, ...
						r.parameters.randSeed));
		cset.type = r.parameters.dataType;
	end % function

	% ======================================================================
	%> @brief Increases the radius of centroid intervals
	%> @details Increases the radius of centroid intervals
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.centroidSet
	%> @param r Experiment run information
	%> @param radius The radius percent to place between the interval bounds and midpoint
	%> @retval r Experiment run information
	% ======================================================================
	function r = widenCentroids(r,radius)
		import ikmeans.logic.*
		import ikmeans.entity.*
		
		% setup logging and timing
		logt = logType.INIT;
		r = logL.trace(r,logt,'centroidL.widenCentroids()');
		r = logL.info(r,logt,sprintf('Setting initial centroid interval radius to %9.9f',radius));
		r = timeL.startTime(r);

		% gather information
		fullfile = strcat(r.parameters.sourcePath,r.parameters.filename);
		[p,n,e] = fileparts(fullfile);

		% widen the radius of the intervals
		[r,r.project.initialCentroids.values] = centroidL.widenCentroidsSimple(r,radius,r.project.initialCentroids.values);

		% save the updated centroids and change the datatype
		r.project.centroids.values = r.project.initialCentroids.values;
		r.project.source.type = dataType.WIDEINTERVAL;
		r.project.source.name = upper(sprintf('%s_WIDEINTERVAL',strrep(n,' ', '_')));
		r.project.initialCentroids.name = upper(sprintf('%s_%s_INITL_%6.0f', ...
						r.project.source.name, ...
						initType.toFixedString(r.parameters.initType), ...
						r.parameters.randSeed));
		r.project.centroids.name = upper(sprintf('%s_%s_FINAL_%6.0f', ...
						r.project.source.name, ...
						initType.toFixedString(r.parameters.initType), ...
						r.parameters.randSeed));
		r.project.initialCentroids.type =  dataType.WIDEINTERVAL;
		r.project.centroids.type = dataType.WIDEINTERVAL;
		r = timeL.endTime(r,logt);
		r = logL.trace(r,logt,'centroidL.widenCentroids() complete');
	end % function

	% ======================================================================
	%> @brief Increases the radius of centroid intervals without using or changing runtime information
	%> @details Increases the radius of centroid intervals without using or changing runtime information
	%>
	%> @see ikmeans.entity.run
	%> @param r Experiment run information
	%> @param radius The radius percent to place between the interval bounds and midpoint
	%> @param centroids The centroids to widen
	%> @retval r Experiment run information
	%> @retval centroids The newly widened centroids
	% ======================================================================
	function [r,centroids] = widenCentroidsSimple(r,radius,centroids)
		% widen the radius of the intervals
		centroids = midrad(mid(centroids),radius);
	end % function


end % methods

end % classdef

