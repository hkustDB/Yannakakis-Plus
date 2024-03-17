create or replace view aggView1473721553035101694 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin2700545978645709438 as select movie_id as v23, v35 from movie_keyword as mk, aggView1473721553035101694 where mk.keyword_id=aggView1473721553035101694.v8;
create or replace view aggView867712565187549656 as select id as v14, name as v36 from name as n;
create or replace view aggJoin6538043339384134190 as select movie_id as v23, v36 from cast_info as ci, aggView867712565187549656 where ci.person_id=aggView867712565187549656.v14;
create or replace view aggView670762514267139447 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin5769316040321943459 as select v23, v35, v37 from aggJoin2700545978645709438 join aggView670762514267139447 using(v23);
create or replace view aggView3121713719356278319 as select v23, MIN(v36) as v36 from aggJoin6538043339384134190 group by v23;
create or replace view aggJoin503013375032476712 as select v35 as v35, v37 as v37, v36 from aggJoin5769316040321943459 join aggView3121713719356278319 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin503013375032476712;
