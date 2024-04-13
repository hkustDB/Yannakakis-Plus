create or replace view aggView1213943996756724482 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin2537546159549498453 as select movie_id as v23, v35 from movie_keyword as mk, aggView1213943996756724482 where mk.keyword_id=aggView1213943996756724482.v8;
create or replace view aggView1187171908074867197 as select id as v14, name as v36 from name as n;
create or replace view aggJoin5243983651826089550 as select movie_id as v23, v36 from cast_info as ci, aggView1187171908074867197 where ci.person_id=aggView1187171908074867197.v14;
create or replace view aggView5580113141271873528 as select v23, MIN(v35) as v35 from aggJoin2537546159549498453 group by v23,v35;
create or replace view aggJoin5755645061983654152 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView5580113141271873528 where t.id=aggView5580113141271873528.v23 and production_year>2000;
create or replace view aggView7427232454086420630 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin5755645061983654152 group by v23,v35;
create or replace view aggJoin7040748586283110385 as select v36 as v36, v35, v37 from aggJoin5243983651826089550 join aggView7427232454086420630 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7040748586283110385;
