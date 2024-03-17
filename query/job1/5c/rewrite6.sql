create or replace view aggView2277886410169028422 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2910754664139948715 as select movie_id as v15, note as v9 from movie_companies as mc, aggView2277886410169028422 where mc.company_type_id=aggView2277886410169028422.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView8943232899573054017 as select v15 from aggJoin2910754664139948715 group by v15;
create or replace view aggJoin6573874482012126806 as select id as v15, title as v16 from title as t, aggView8943232899573054017 where t.id=aggView8943232899573054017.v15 and production_year>1990;
create or replace view aggView6013062531840232516 as select id as v3 from info_type as it;
create or replace view aggJoin3342027995007685891 as select movie_id as v15 from movie_info as mi, aggView6013062531840232516 where mi.info_type_id=aggView6013062531840232516.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView9000374381068122214 as select v15 from aggJoin3342027995007685891 group by v15;
create or replace view aggJoin3380203323413845506 as select v16 from aggJoin6573874482012126806 join aggView9000374381068122214 using(v15);
select MIN(v16) as v27 from aggJoin3380203323413845506;
