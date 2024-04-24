create or replace view aggView6542626025489708703 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1250759575090545629 as select movie_id as v23, v35 from movie_keyword as mk, aggView6542626025489708703 where mk.keyword_id=aggView6542626025489708703.v8;
create or replace view aggView4576427314150196357 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1079693586621674756 as select movie_id as v23, v36 from cast_info as ci, aggView4576427314150196357 where ci.person_id=aggView4576427314150196357.v14;
create or replace view aggView3823047311524019272 as select v23, MIN(v35) as v35 from aggJoin1250759575090545629 group by v23,v35;
create or replace view aggJoin2845187669904145833 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView3823047311524019272 where t.id=aggView3823047311524019272.v23 and production_year>2000;
create or replace view aggView8071367179542717068 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin2845187669904145833 group by v23,v35;
create or replace view aggJoin4944569121677857921 as select v36 as v36, v35, v37 from aggJoin1079693586621674756 join aggView8071367179542717068 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4944569121677857921;
