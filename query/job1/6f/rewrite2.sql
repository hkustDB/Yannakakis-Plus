create or replace view aggView752256544716255863 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1008061119658608705 as select movie_id as v23, v35 from movie_keyword as mk, aggView752256544716255863 where mk.keyword_id=aggView752256544716255863.v8;
create or replace view aggView4190940532597763456 as select id as v14, name as v36 from name as n;
create or replace view aggJoin7112798173965038569 as select movie_id as v23, v36 from cast_info as ci, aggView4190940532597763456 where ci.person_id=aggView4190940532597763456.v14;
create or replace view aggView3925843882870401019 as select v23, MIN(v35) as v35 from aggJoin1008061119658608705 group by v23;
create or replace view aggJoin7104512519540091854 as select id as v23, title as v24, v35 from title as t, aggView3925843882870401019 where t.id=aggView3925843882870401019.v23 and production_year>2000;
create or replace view aggView3765843069868892245 as select v23, MIN(v36) as v36 from aggJoin7112798173965038569 group by v23;
create or replace view aggJoin1545072881575849737 as select v24, v35 as v35, v36 from aggJoin7104512519540091854 join aggView3765843069868892245 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin1545072881575849737;
