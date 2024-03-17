create or replace view aggView7689297836378449383 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3609410692430324187 as select movie_id as v23, v36 from cast_info as ci, aggView7689297836378449383 where ci.person_id=aggView7689297836378449383.v14;
create or replace view aggView3072063910897343899 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3026156952301071997 as select movie_id as v23, v35 from movie_keyword as mk, aggView3072063910897343899 where mk.keyword_id=aggView3072063910897343899.v8;
create or replace view aggView5017664049430588785 as select v23, MIN(v36) as v36 from aggJoin3609410692430324187 group by v23;
create or replace view aggJoin8815981628683500835 as select v23, v35 as v35, v36 from aggJoin3026156952301071997 join aggView5017664049430588785 using(v23);
create or replace view aggView8999560448438636885 as select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin8815981628683500835 group by v23;
create or replace view aggJoin6061317214887527115 as select title as v24, v35, v36 from title as t, aggView8999560448438636885 where t.id=aggView8999560448438636885.v23 and production_year>2014;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin6061317214887527115;
