create or replace view aggView3253335401491918316 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin7067353919769764352 as select movie_id as v23, v35 from movie_keyword as mk, aggView3253335401491918316 where mk.keyword_id=aggView3253335401491918316.v8;
create or replace view aggView3068614076770693622 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin808218134394098886 as select movie_id as v23, v36 from cast_info as ci, aggView3068614076770693622 where ci.person_id=aggView3068614076770693622.v14;
create or replace view aggView976255388351332218 as select v23, MIN(v36) as v36 from aggJoin808218134394098886 group by v23;
create or replace view aggJoin5897006663391161432 as select v23, v35 as v35, v36 from aggJoin7067353919769764352 join aggView976255388351332218 using(v23);
create or replace view aggView2384059528040007263 as select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin5897006663391161432 group by v23;
create or replace view aggJoin1395941406026902204 as select title as v24, v35, v36 from title as t, aggView2384059528040007263 where t.id=aggView2384059528040007263.v23 and production_year>2000;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin1395941406026902204;
