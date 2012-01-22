#!/bin/sh
SRCDIR=/intervalcluster/src
DESTDIR=/tmp
cd ${DESTDIR}
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/getSourceConfig.m > +ikmeans/getSourceConfig.mperl ./m2cpp.pl ${SRCDIR}/+ikmeans/runall.m > +ikmeans/runall.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/runone.m > +ikmeans/runone.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/setupGlobal.m > +ikmeans/setupGlobal.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/test.m > +ikmeans/test.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+logic/centroidL.m > +ikmeans/+logic/centroidL.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+logic/kmeansL.m > +ikmeans/+logic/kmeansL.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+logic/logL.m > +ikmeans/+logic/logL.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+logic/membershipL.m > +ikmeans/+logic/membershipL.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+logic/qualityL.m > +ikmeans/+logic/qualityL.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+logic/reportL.m > +ikmeans/+logic/reportL.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+logic/runL.m > +ikmeans/+logic/runL.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+logic/sourceL.m > +ikmeans/+logic/sourceL.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+logic/timeL.m > +ikmeans/+logic/timeL.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+data/centroidD.m > +ikmeans/+data/centroidD.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+data/logD.m > +ikmeans/+data/logD.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+data/membershipD.m > +ikmeans/+data/membershipD.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+data/qualityD.m > +ikmeans/+data/qualityD.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+data/reportD.m > +ikmeans/+data/reportD.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+data/sourceD.m > +ikmeans/+data/sourceD.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+data/timeD.m > +ikmeans/+data/timeD.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/aggregateRR.m > +ikmeans/+entity/aggregateRR.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/batch.m > +ikmeans/+entity/batch.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/centroidSet.m > +ikmeans/+entity/centroidSet.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/colorType.m > +ikmeans/+entity/colorType.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/data.m > +ikmeans/+entity/data.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/dataType.m > +ikmeans/+entity/dataType.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/initType.m > +ikmeans/+entity/initType.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/logLevel.m > +ikmeans/+entity/logLevel.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/logMessage.m > +ikmeans/+entity/logMessage.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/logType.m > +ikmeans/+entity/logType.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/logWriter.m > +ikmeans/+entity/logWriter.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/membership.m > +ikmeans/+entity/membership.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/parameters.m > +ikmeans/+entity/parameters.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/project.m > +ikmeans/+entity/project.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/quality.m > +ikmeans/+entity/quality.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/qualityRR.m > +ikmeans/+entity/qualityRR.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/qualityType.m > +ikmeans/+entity/qualityType.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/results.m > +ikmeans/+entity/results.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/run.m > +ikmeans/+entity/run.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/source.m > +ikmeans/+entity/source.m
perl ./m2cpp.pl ${SRCDIR}/+ikmeans/+entity/timing.m > +ikmeans/+entity/timing.m

