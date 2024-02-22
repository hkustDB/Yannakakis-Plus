create or replace view aggView8633214572428239769 as select src as v8, SUM(dst) as v11, COUNT(*) as annot from Graph as g5 group by src;
create or replace view aggJoin791802775562270076 as select src as v6, dst as v8, v11, annot from Graph as g4, aggView8633214572428239769 where g4.dst=aggView8633214572428239769.v8;
create or replace view aggView5281990486442559803 as select dst as v2, COUNT(*) as annot from Graph as g1 group by dst;
create or replace view aggJoin6732483539764285966 as select src as v2, dst as v4, annot from Graph as g2, aggView5281990486442559803 where g2.src=aggView5281990486442559803.v2;
create or replace view semiJoinView6727745727831982044 as select src as v4, dst as v6 from Graph AS g3 where (dst) in (select v6 from aggJoin791802775562270076);
create or replace view semiJoinView2077681500783549161 as select v2, v4, annot from aggJoin6732483539764285966 where (v4) in (select v4 from semiJoinView6727745727831982044);
# +. SemiEnumerate
create or replace view semiEnum7827044691138397726 as select annot, v6, v2 from semiJoinView2077681500783549161 join semiJoinView6727745727831982044 using(v4);
# +. SemiEnumerate
create or replace view semiEnum762899779909459667 as select v8, v11*semiEnum7827044691138397726.annot as v11, v2 from semiEnum7827044691138397726 join aggJoin791802775562270076 using(v6);
select v2,v8,SUM(v11) as v11 from semiEnum762899779909459667 group by v2, v8;
