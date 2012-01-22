%> @file test.m
%> @brief Sets up and executes a single K-Means experiment without using the automation logic
%> @details Sets up and executes a single K-Means experiment by directly calling the API instead of using the automation logic
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
fname='Hepta';
nCentroids = 7;
nBlocks = 10;

% SETUP PARAMETERS
path(pathdef);
path(path,'/intervalcluster_project/intervalcluster/src'); 
path(path,'/intervalcluster_project/intervalcluster/lib'); 
clear runs p w s t itypes rid rands reportFile;
runs = ikmeans.entity.run.empty(0,0);

reportFile = strcat('/intervalcluster_project/results/',lower(fname),'.csv');
p = ikmeans.entity.parameters();
p.resultsPath=strcat('/intervalcluster_project/results/',lower(fname));
p.sourcePath='/intervalcluster_project/data/';
p.membershipFile = strcat('/intervalcluster_project/data/',fname,'_amembership.csv');
p.filename = strcat(fname,'.csv');
p.nCentroids = nCentroids;
p.iterations = 10;
p.nBlocks = nBlocks;
p.epsilon = 0.1;
p.sourceType = ikmeans.entity.dataType.STANDARD;
%p.dataType = ikmeans.entity.dataType.STANDARD;
p.dataType = ikmeans.entity.dataType.INTERVAL;
p.qualityType = ikmeans.entity.qualityType.JACCARD;


% SETUP LOG
w = ikmeans.entity.logWriter();
w.id=length(p.writers) + 1;
w.type = ikmeans.entity.logType.ALL;
w.fileId = -1; % print to screen
%w.level = ikmeans.entity.logLevel.STEP;
w.level = ikmeans.entity.logLevel.TRACE;
%w.level = ikmeans.entity.logLevel.DEBUG;
%w.level = ikmeans.entity.logLevel.INFO;
%w.level = ikmeans.entity.logLevel.WARN;
p.writers(w.id) = w;
format('long');
p.initType = ikmeans.entity.initType.PEAK;
p.randSeed = 6140723;

% SOME SETUP AND INITIAL LOGGING
r = ikmeans.entity.run();
r.parameters = p;
logt = ikmeans.entity.logType.RUN;
r=ikmeans.logic.logL.info(r,logt,sprintf('Parameter sourcePath     = %s'   ,r.parameters.sourcePath));
r=ikmeans.logic.logL.info(r,logt,sprintf('Parameter resultsPath    = %s'   ,r.parameters.resultsPath));
r=ikmeans.logic.logL.info(r,logt,sprintf('Parameter filename       = %s'   ,r.parameters.filename));
r=ikmeans.logic.logL.info(r,logt,sprintf('Parameter membershipFile = %s'   ,r.parameters.membershipFile));
r=ikmeans.logic.logL.info(r,logt,sprintf('Parameter nCentroids     = %9.0f',r.parameters.nCentroids));
r=ikmeans.logic.logL.info(r,logt,sprintf('Parameter nBlocks        = %9.0f',r.parameters.nBlocks));
r=ikmeans.logic.logL.info(r,logt,sprintf('Parameter randSeed       = %9.0f',r.parameters.randSeed));
r=ikmeans.logic.logL.info(r,logt,sprintf('Parameter iterations     = %9.0f',r.parameters.iterations));
r=ikmeans.logic.logL.info(r,logt,sprintf('Parameter epsilon        = %9.9f',r.parameters.epsilon));
r=ikmeans.logic.logL.info(r,logt,sprintf('Parameter sourceType     = %s'   ,ikmeans.entity.dataType.toString(r.parameters.sourceType)));
r=ikmeans.logic.logL.info(r,logt,sprintf('Parameter dataType       = %s'   ,ikmeans.entity.dataType.toString(r.parameters.dataType)));
r=ikmeans.logic.logL.info(r,logt,sprintf('Parameter initType       = %s'   ,ikmeans.entity.initType.toString(r.parameters.initType)));
r=ikmeans.logic.logL.info(r,logt,sprintf('Parameter qualityType    = %s'   ,ikmeans.entity.qualityType.toString(r.parameters.qualityType)));

r=ikmeans.logic.sSourceL.load(r);
r=ikmeans.logic.iSourceL.convertFromStandard(r);

% Initialize Centroids
%r = ikmeans.logic.sCentroidL.initCentroids(r);
r = ikmeans.logic.iCentroidL.initCentroids(r);
	
% Run K-Means
r = ikmeans.logic.iKmeansL.run(r);

% Calculate quality
r = ikmeans.logic.iQualityL.calculateQuality(r);
		
% Save centroids
%r = ikmeans.logic.iCentroidL.save(r);

% Save membership
r = ikmeans.logic.membershipL.save(r,r.project.members);
		
% Plot membership
r = ikmeans.logic.membershipL.plot(r,r.project.members,r.project.centroids);

r = ikmeans.logic.logL.info(r,ikmeans.entity.logType.RUN,'Run complete');
	
% Save timings
ikmeans.logic.timeL.save(r,logType.ALL);

% Save logs
%ikmeans.logic.logL.save(r);

