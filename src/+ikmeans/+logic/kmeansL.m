%> @file kmeansL.m
%> @brief Provides the logic necessary to execute the K-Means algorithm
%> @details Provides the logic necessary to execute the K-Means algorithm
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Provides the logic necessary to execute the K-Means algorithm
%> @details Provides the logic necessary to execute the K-Means algorithm
% ======================================================================
classdef kmeansL

methods(Static)

	% ======================================================================
	%> @brief The starting point for the K-Means algorithm
	%> @details Contains the primary K-Means loop and objective calculations. Controls the K-Means algorithm flow and executes each step. 
	%>
	%> @see ikmeans.entity.run
	%> @param r Experiment run information
	%> @retval r Experiment run information
	% ======================================================================
	function r = run(r)
		import ikmeans.logic.*
		import ikmeans.entity.*
		logt = logType.RUN;
		r = logL.trace(r,logt,'kmeansL.run()');
		r = logL.info(r,logt,sprintf('Running K-Means: %s',r.project.source.name));
		r = timeL.startTime(r);

		%gather information
		source = r.project.source;
		cset = r.project.centroids;
		data = source.values;
		centroids = cset.values;
		epsilon = r.parameters.epsilon;
		iterations = r.parameters.iterations;

		clusters = centroids;
		[nPoints,nDim] = size(data);
		[nCluster,trash] = size(centroids);
		
		% execute K-Means
		r = logL.info(r,logt, 'Assigning points to clusters');
		[r,membership] = kmeansL.assignPoints(r,clusters, data);
		r = logL.info(r,logt, 'Calculating Initial Objective');
		[r,objective] = kmeansL.calcObjective(r,clusters);
		
		for i = 1:iterations
			r = logL.info(r,logt, sprintf('Iteration: %d', i));
			
			r = logL.info(r,logt, '  Finding cluster centers');
			[r,clusters] = kmeansL.findClusterCenters(r,nCluster, membership, data);
			
			r = logL.info(r,logt, '  Assigning points to clusters');
			[r,membership] = kmeansL.assignPoints(r,clusters, data);
			
			r = logL.info(r,logt, '  Calculating Objective');
			[r,newObjective] = kmeansL.calcObjective(r,clusters);
			if (abs(newObjective - objective) <= epsilon)
				break;
			end % if
			objective = newObjective;
			r.results.actualIterations = i;
		end % for

		% save the result
		r.project.centroids.values = clusters;

		m = membershipL.getNewMembership(r);
		m.values = membership;
		r.project.members = m;
		
		r = timeL.endTime(r,logt);
		r = logL.trace(r,logt,'kmeansL.run() complete');
	end % function

	% ======================================================================
	%> @brief Assign points to the nearest centroid
	%> @details Assign points to the nearest centroid
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.centroidSet
	%> @see ikmeans.entity.membership
	%> @param r Experiment run information
	%> @param clusters The current list of centroid positions 
	%> @param data The source data set
	%> @retval r Experiment run information
	%> @retval membership Point/cluster assignment
	% ======================================================================
	function [r, membership] = assignPoints(r, clusters, data)
		import ikmeans.logic.*
		import ikmeans.entity.*
		logt = logType.RUN;
		r = logL.trace(r,logt,'kmeansL.assignPoints() start');
		
		% initialize containers and gather data
		switch r.parameters.dataType
				case dataType.INTERVAL
					dataL = r.project.source.lowerValues;
					dataU = r.project.source.upperValues;
					clustersL = inf(clusters);
					clustersU = sup(clusters);
				case dataType.WIDEINTERVAL
					dataL = r.project.source.lowerValues;
					dataU = r.project.source.upperValues;
					clustersL = inf(clusters);
					clustersU = sup(clusters);
			end %switch
		clusterSize = size(clusters);
		dataSize = size(data);
		nCluster = clusterSize(1,1);
		nPoints = dataSize(1,1);
		membership = zeros(nPoints,1);

		% loop through each point
		for p = 1:nPoints
			oldDist = -1.0;
			newDist = -1.0;
			iCluster = -1;
			%find the closest centroid
			for c = 1:nCluster
				switch r.parameters.dataType
					case dataType.STANDARD
						newDist = kmeansL.manDistance(data(p,:), clusters(c,:));
					case dataType.INTERVAL
						newDist = kmeansL.iManDistance(dataL(p,:),dataU(p,:),clustersL(c,:),clustersU(c,:));
					case dataType.WIDEINTERVAL
						newDist = kmeansL.iManDistance(dataL(p,:),dataU(p,:),clustersL(c,:),clustersU(c,:));
				end %switch
			
				if (oldDist == -1 || newDist < oldDist)
					oldDist = newDist;
					iCluster = c;
				end % if
			end % for
			% assign the point to that centroid
			membership(p) = iCluster;
		end % for

		r = logL.trace(r,logt,'iKmeansL.assignPoints() complete');
	end % function

	% ======================================================================
	%> @brief Move the centroid to the center of its assigned points
	%> @details Move the centroid to the center of its assigned points by averaging each points' coordinates
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.centroidSet
	%> @see ikmeans.entity.membership
	%> @param r Experiment run information
	%> @param nCluster The number of clusters in this source
	%> @param membership The current point/cluster assignment
	%> @param data The source data set
	%> @retval r Experiment run information
	%> @retval clusters The repositioned clusters
	% ======================================================================
	function [r, clusters]  = findClusterCenters(r, nCluster, membership, data)
		import ikmeans.logic.*
		import ikmeans.entity.*
		
		% gather data and initialize containers
		dataSize = size(data);
		nPoints = dataSize(1,1);
		nDim = dataSize(1,2);
		
		clusters = sourceL.convertValue(r,zeros(nCluster,nDim));
		
		% loop through each cluster and dimension
		for d = 1:nDim
			% sum up the data coordinate values and count them
			nMember = sourceL.convertValue(r,zeros(nCluster,1));
			coord = sourceL.convertValue(r,zeros(nCluster,1));
			for p = 1:nPoints
				nMember(membership(p)) = nMember(membership(p))+1;
				coord(membership(p)) = coord(membership(p)) + data(p,d);
			end %for p

			for c = 1:nCluster
				if (nMember > 0)
					% the new cluster-dimension value is the sum / the count
					clusters(c,d) = coord(c)/nMember(c);
				end %if
			end %for c
		end %for d
		
		if (r.parameters.dataType == dataType.WIDEINTERVAL && r.parameters.widenAlways == 1)
			[r,clusters] = centroidL.widenCentroidsSimple(r,r.parameters.radius,clusters);
		end %if
		
	end % function

	% ======================================================================
	%> @brief Provides a numerical estimate of the position of all centroids
	%> @details Provides a numerical estimate of the position of all centroids. Comparing two objective values can determine if the centroids have "moved"
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.centroidSet
	%> @param r Experiment run information
	%> @param clusters The current centroid locations
	%> @retval r Experiment run information
	%> @retval objective The numerical representation of the centroid positions
	% ======================================================================
	function [r,objective] = calcObjective(r,clusters)
		import ikmeans.logic.*
		import ikmeans.entity.*
		% This may be incorrect, but this simply adds together all of the coordinates of all the clusters
		objective= sum(sum(clusters)');
	end % function

	% ======================================================================
	%> @brief Calculates the Manhattahan distance between two decimal points
	%> @details Calculates the Manhattahan distance between two decimal points by summing the difference between each dimension's coordinates
	%>
	%> @param p1 The first point
	%> @param p2 The second point
	%> @retval distance The distance between the first and second points
	% ======================================================================
	function [distance] = manDistance(p1,p2)
		import ikmeans.logic.*
		import ikmeans.entity.*
		pSize = size(p1);
		nDim = pSize(1,2);
		distance = 0;
		for d = 1:nDim
			distance = distance + abs(p1(1,d) - p2(1,d));
		end %for d
	end % function
	
	% ======================================================================
	%> @brief Calculates the Manhattahan distance between two interval points
	%> @details Calculates the Manhattahan distance between two interval points by summing the difference between each dimension's coordinates and taking overlap into account
	%>
	%> @param p1LA All of the first point's lower-bound values
	%> @param p1UA All of the first point's upper-bound values
	%> @param p2LA All of the second point's lower-bound values
	%> @param p2UA All of the second point's upper-bound values
	%> @retval distance The distance between the first and second points in decimal form
	% ======================================================================
	function [distance] = iManDistance(p1LA,p1UA,p2LA,p2UA)
		import ikmeans.logic.*
		import ikmeans.entity.*

		pSize = size(p1LA);
		nDim = pSize(1,2);
		distance = 0;
		mind = 0;

		for d = 1:nDim
			% The original formula: distance = distance + abs(p1(1,d) - p2(1,d));

			% get the information for this dimension
			p1L = p1LA(d);
			p1U = p1UA(d);
			p2L = p2LA(d);
			p2U = p2UA(d);

			% Find the difference between each lower/upper bound combination
			% Save the smallest combination for later
			% lower,lower
			tmpd = abs(p1L - p2L);
			mind = tmpd;

			% lower,upper
			tmpd = abs(p1L - p2U);
			if (tmpd < mind) mind = tmpd; end

			% upper,lower
			tmpd = abs(p1U - p2L);
			if (tmpd < mind)  mind = tmpd; end
			
			% upper,upper
			tmpd = abs(p1U - p2U);
			if (tmpd < mind) mind = tmpd; end

			% If any of the combinations overlap, set the distance to 0
			if ( (p1L >= p2L && p1L <= p2U) ... % p1.lower
			|| (p1U >= p2L && p1U <= p2U) ... % p1.upper
			|| (p2L >= p1L && p2L <= p1U) ... % p2.lower
			|| (p2U >= p1L && p2U <= p1U) ... % p2.upper
			)
				mind = 0.0;
			end % if

			% Add this coordiate's distance to the total
			distance = distance + mind;
		end %for d
	end % function

end % methods

end % classdef

