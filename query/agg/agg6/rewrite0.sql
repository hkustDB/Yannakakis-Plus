create or replace view aggView7721589788594901493 as select SUM(dst) as v11, COUNT(*) as annot from Graph as g5 group by ;
create or replace view aggJoin8374884001403070685 as select src as v4, dst as v6, v11, annot from Graph as g3, aggView7721589788594901493;
create or replace view aggView3552558907316077951 as select src as v6, COUNT(*) as annot from Graph as g4 group by src;
create or replace view aggJoin2478223462257661779 as select v4, v6, v11*aggView3552558907316077951.annot as v11, aggJoin8374884001403070685.annot * aggView3552558907316077951.annot as annot from aggJoin8374884001403070685 join aggView3552558907316077951 using(v6);
create or replace view aggView2723280950136675973 as select dst as v2, COUNT(*) as annot from Graph as g1 group by dst;
create or replace view aggJoin4306570645613902793 as select src as v2, dst as v4, annot from Graph as g2, aggView2723280950136675973 where g2.src=aggView2723280950136675973.v2;
create or replace view semiJoinView2545618264535895984 as select v4, v6, v11, annot from aggJoin2478223462257661779 where (v4) in (select v4 from aggJoin4306570645613902793);
# +. SemiEnumerate
create or replace view semiEnum2877072720671662307 as select v11*aggJoin4306570645613902793.annot as v11, v6, v4, v2 from semiJoinView2545618264535895984 join aggJoin4306570645613902793 using(v4);
select v2,v4,v6,SUM(v11) as v11 from semiEnum2877072720671662307 group by v2, v4, v6;
