%> @file membershipL.m
%> @brief Load, save, plot, and convert membership information
%> @details Load, save, plot, and convert membership information
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
%> @brief Load, save, plot, and convert membership information
%> @details Load, save, plot, and convert membership information
% ======================================================================
classdef membershipL

methods(Static)

	% ======================================================================
	%> @brief Provides an membership container with default values
	%> @details Provides an membership container with default values
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.membership
	%> @param r Experiment run information
	%> @retval m The default membership container
	% ======================================================================
	function m = getNewMembership(r)
		import ikmeans.logic.*
		import ikmeans.entity.*
		r = logL.trace(r,logType.RUN,'membershipL.getNewMembership()');	
	
		m = membership();
		cset = r.project.centroids;
		source = r.project.source;
		m.name = upper(sprintf('%s_MEMBERS',cset.name));

	end % function

	% ======================================================================
	%> @brief Load membership information from a file
	%> @details Load membership information from a file and store in loadedMembers
	%>
	%> @see ikmeans.entity.run
	%> @param r Experiment run information
	%> @param fileName The file containing the membership information
	%> @retval r Experiment run information
	% ======================================================================
	function r = load(r,fileName)
		import ikmeans.data.*
		import ikmeans.entity.*
		import ikmeans.logic.membershipL

		m = membershipL.getNewMembership(r);
		[r,m] = membershipD.load(r,m,fileName);
		r.project.loadedMembers = m;
	end % function

	% ======================================================================
	%> @brief Save membership information to a file
	%> @details Save membership information to a file with a filename based off of the experiment parameters
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.membership
	%> @param r Experiment run information
	%> @param m The membership information
	%> @retval r Experiment run information
	% ======================================================================
	function r = save(r,m)
		import ikmeans.logic.*
		import ikmeans.data.*
		import ikmeans.entity.*

		logt = logType.SAVE;
		fn = strcat(r.parameters.resultsPath,filesep,lower(m.name),r.parameters.extension);
		r = logL.info(r,logt,sprintf('Saving membership to: %s',fn));
		
		r = membershipD.save(r,r.project.members,fn);

	end % function

	% ======================================================================
	%> @brief Plot membership information and save to a file
	%> @details Plot membership information and save to a file with a filename based off of the experiment parameters
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.membership
	%> @see ikmeans.entity.centroidSet
	%> @param r Experiment run information
	%> @param m The membership information
	%> @param cset The centroid locations to plot against the data set
	%> @retval r Experiment run information
	% ======================================================================
	function r = plot(r,m,cset)
		import ikmeans.logic.*
		import ikmeans.data.*
		import ikmeans.entity.*
		
		logt = logType.SAVE;
		r = logL.trace(r,logt,'membershipL.plot()');

		% generate the destination file name		
		fn = strcat(r.parameters.resultsPath,filesep,lower(m.name),'.png');
		r = logL.info(r,logt,sprintf('Saving membership plot to file: %s',fn));
		
		% gather data
		source = r.project.source;
		data = source.values;
		centroids = cset.values;

		% convert to decimal. Use midpoints of intervals
		switch r.parameters.dataType
			case dataType.STANDARD
				% do nothing
			case dataType.INTERVAL
				data = mid(data);
				centroids = mid(centroids);
			case dataType.WIDEINTERVAL
				data = mid(data);
				centroids = mid(centroids);
			otherwise
				r = logL.error(r,logt,sprintf('Unknown data type: %i',r.parameters.dataType));
		end %switch


		[nPoints,nDim] = size(data);
		[nCluster,trash] = size(centroids);

		% Group the data points by centroid
		[r,dgroups] = membershipL.dataByCentroid(r,m,cset);

		% initialize the figure
		f = figure(1);
		set(f,'visible','off');
		set(f,'Position',[0,0,600,600]);
		
		% plot data to auto set camera angles
		if (nDim == 2)
				plot(data(:,1),data(:,2),'w.');
			else
				plot3(data(:,1),data(:,2),data(:,3),'w.');
		end % if

		% Now, plot for real
		r = logL.step(r,logt,'Generating plot');
		title(sprintf('Membership for %s',m.name),'Interpreter','none');
		hold on;

		% Loop through each cluster and plot its data points with a unique color
		for ci = 1:nCluster
			dc = dgroups(ci).values;
			if (nDim == 2)
				plot(dc(:,1),dc(:,2),sprintf('%s*',colorType.toChar(mod(ci,7))));
			else
				plot3(dc(:,1),dc(:,2),dc(:,3),sprintf('%s*',colorType.toChar(mod(ci,7))));
			end % if
		end % for ci
		camva('auto');
		hold off;

		% save the plot
		saveas(f,fn,'png');
		close(f);

	end % function

	% ======================================================================
	%> @brief Divide the source data into groups based off of centroid membership
	%> @details Divide the source data into groups based off of centroid membership
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.membership
	%> @see ikmeans.entity.centroidSet
	%> @param r Experiment run information
	%> @param m The membership information
	%> @param cset The centroid locations
	%> @retval r Experiment run information
	%> @retval dataGroups A set of data groups, one per centroid, that contains the member points for that centroid
	% ======================================================================
	function [r,dataGroups] = dataByCentroid(r,m,cset)
		import ikmeans.logic.*
		import ikmeans.data.*
		import ikmeans.entity.*
		logt = logType.RUN;
		r = logL.trace(r,logt,'membershipL.dataByCentroid()');

		source = r.project.source;
		data = source.values;
		centroids = cset.values;

		switch r.parameters.dataType
			case dataType.STANDARD
				% do nothing
			case dataType.INTERVAL
				data = mid(data);
				centroids = mid(centroids);
			case dataType.WIDEINTERVAL
				data = mid(data);
				centroids = mid(centroids);
			otherwise
				r = logL.error(r,logt,sprintf('Unknown data type: %i',r.parameters.dataType));
		end %switch

		[nPoints,nDim] = size(data);
		[nCluster,trash] = size(centroids);

		[r,members] = membershipL.appendRowIndex(r,m,cset);
		dataGroups = membership.empty(0,0);
		
		% setup groups
		for ci = 1:nCluster
			mg = membership();
			dataGroups(ci) = mg;
		end % for ci

		% add values to groups
		for pi = 1:nPoints
			for ci = 1:nCluster
				if (ci == members(pi,2))
					[rows,trash] = size(dataGroups(ci).values);
					dataGroups(ci).values(rows+1,:) = data(pi,:);
					break;
				end % if
			end % for ci
		end % for pi
		
	end % function

	% ======================================================================
	%> @brief Append the row index to the membership information
	%> @details Append the row index to the membership information by adding a preceding dimension to each index
	%>
	%> @see ikmeans.entity.run
	%> @see ikmeans.entity.membership
	%> @see ikmeans.entity.centroidSet
	%> @param r Experiment run information
	%> @param m The membership information
	%> @param cset The centroid locations
	%> @retval r Experiment run information
	%> @retval members The membership information with the appended row indicies
	% ======================================================================
	function [r,members] = appendRowIndex(r,m,cset)
		import ikmeans.logic.*
		import ikmeans.data.*
		import ikmeans.entity.*
		
		logt = logType.RUN;
		r = logL.trace(r,logt,'membershipL.appendRowIndex()');
		
		data = r.project.source.values;

		[nPoints,nDim] = size(data);

		members = [[1:nPoints]' m.values];

	end % function

end % methods
end % classdef

