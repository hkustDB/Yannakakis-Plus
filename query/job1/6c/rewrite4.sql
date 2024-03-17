create or replace view aggView8706593346974968272 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5904101574263130343 as select movie_id as v23, v35 from movie_keyword as mk, aggView8706593346974968272 where mk.keyword_id=aggView8706593346974968272.v8;
create or replace view aggView4521088659669763169 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1634158049292564588 as select movie_id as v23, v36 from cast_info as ci, aggView4521088659669763169 where ci.person_id=aggView4521088659669763169.v14;
create or replace view aggView8707124755145862058 as select v23, MIN(v35) as v35 from aggJoin5904101574263130343 group by v23;
create or replace view aggJoin6531721258264022560 as select id as v23, title as v24, v35 from title as t, aggView8707124755145862058 where t.id=aggView8707124755145862058.v23 and production_year>2014;
create or replace view aggView4207041688096886090 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin6531721258264022560 group by v23;
create or replace view aggJoin8603370081712970190 as select v36 as v36, v35, v37 from aggJoin1634158049292564588 join aggView4207041688096886090 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8603370081712970190;
