create or replace view aggView8143526466708436062 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin8320327556516423127 as select movie_id as v23, v35 from movie_keyword as mk, aggView8143526466708436062 where mk.keyword_id=aggView8143526466708436062.v8;
create or replace view aggView7343638699175948905 as select id as v14, name as v36 from name as n;
create or replace view aggJoin1749357133678937191 as select movie_id as v23, v36 from cast_info as ci, aggView7343638699175948905 where ci.person_id=aggView7343638699175948905.v14;
create or replace view aggView744233155292653612 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin7074244991437847759 as select v23, v36, v37 from aggJoin1749357133678937191 join aggView744233155292653612 using(v23);
create or replace view aggView4635243598927627850 as select v23, MIN(v36) as v36, MIN(v37) as v37 from aggJoin7074244991437847759 group by v23;
create or replace view aggJoin5055822365212547760 as select v35 as v35, v36, v37 from aggJoin8320327556516423127 join aggView4635243598927627850 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5055822365212547760;
