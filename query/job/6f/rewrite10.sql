create or replace view aggView2009744579678955008 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5749783884658226965 as select movie_id as v23, v35 from movie_keyword as mk, aggView2009744579678955008 where mk.keyword_id=aggView2009744579678955008.v8;
create or replace view aggView7507857829458376445 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin1150934056185920249 as select v23, v35, v37 from aggJoin5749783884658226965 join aggView7507857829458376445 using(v23);
create or replace view aggView4354674298298986265 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin1150934056185920249 group by v23;
create or replace view aggJoin979425833328400275 as select person_id as v14, v35, v37 from cast_info as ci, aggView4354674298298986265 where ci.movie_id=aggView4354674298298986265.v23;
create or replace view aggView5359045737208563167 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin979425833328400275 group by v14;
create or replace view aggJoin2519518905558703365 as select name as v15, v35, v37 from name as n, aggView5359045737208563167 where n.id=aggView5359045737208563167.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin2519518905558703365;
