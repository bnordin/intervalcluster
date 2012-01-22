%> @file setupGlobal.m
%> @brief Sets up global parameters that do not change between experiments
%> @details Global parameters including paths, K-Means parameters, source type, quality measure, and log setup.
%> @author Ben Nordin
%> @date 2011-09-01
% ======================================================================
clear rootPath dataPath resultsPath p w fileWriterId;

%paths
rootPath = '/intervalcluster_project';
dataPath = strcat(rootPath,filesep,'data');
resultsPath = strcat(rootPath,filesep,'example_results');
%path(pathdef); path(path,strcat(rootPath,filesep)); path(path,strcat(rootPath,filesep,'fe')); 

p = ikmeans.entity.parameters();
p.sourcePath=strcat(dataPath,filesep);
p.iterations = 10;
p.epsilon = 0.1;
p.sourceType = ikmeans.entity.dataType.STANDARD;
p.qualityType = ikmeans.entity.qualityType.JACCARD;

% screen log
w = ikmeans.entity.logWriter();
w.id=length(p.writers) + 1;
w.type = ikmeans.entity.logType.ALL;
w.fileId = -1; % print to screen
%w.level = ikmeans.entity.logLevel.STEP;
%w.level = ikmeans.entity.logLevel.TRACE;
%w.level = ikmeans.entity.logLevel.DEBUG;
w.level = ikmeans.entity.logLevel.INFO;
%w.level = ikmeans.entity.logLevel.WARN;
p.writers(w.id) = w;

% file log
w.id=length(p.writers) + 1;
w.type = ikmeans.entity.logType.ALL;
w.level = ikmeans.entity.logLevel.INFO;
w.fileId = -1;
p.writers(w.id) = w;

fileWriterId = w.id;

format('long'); % necessary to keep random number precision

