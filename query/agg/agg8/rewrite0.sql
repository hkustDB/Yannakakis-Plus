create or replace view aggView5620823146663223887 as select dst as v2, COUNT(*) as annot from Graph as g1 group by dst;
create or replace view aggJoin6826045806920392623 as select src as v2, dst as v4, annot from Graph as g2, aggView5620823146663223887 where g2.src=aggView5620823146663223887.v2;
create or replace view semiJoinView8875953194954906530 as select v2, v4, annot from aggJoin6826045806920392623 where (v4) in (select src from Graph AS g3);
# +. SemiEnumerate
create or replace view semiEnum4465446351500406064 as select dst as v6, v4, v2 from semiJoinView8875953194954906530, Graph as g3 where g3.src=semiJoinView8875953194954906530.v4;
select v2,v4,v6,v7,v8 from semiEnum4465446351500406064;
