create or replace view aggView8962782151004163792 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin1310570583432714510 as select movie_id as v23, v35 from movie_keyword as mk, aggView8962782151004163792 where mk.keyword_id=aggView8962782151004163792.v8;
create or replace view aggView6998114504371632066 as select v23, MIN(v35) as v35 from aggJoin1310570583432714510 group by v23;
create or replace view aggJoin3068484309808301073 as select id as v23, title as v24, v35 from title as t, aggView6998114504371632066 where t.id=aggView6998114504371632066.v23 and production_year>2010;
create or replace view aggView4885856100825898853 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin3068484309808301073 group by v23;
create or replace view aggJoin2573315708073740180 as select person_id as v14, v35, v37 from cast_info as ci, aggView4885856100825898853 where ci.movie_id=aggView4885856100825898853.v23;
create or replace view aggView1464693855909591122 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin2573315708073740180 group by v14;
create or replace view aggJoin1081379497768789417 as select name as v15, v35, v37 from name as n, aggView1464693855909591122 where n.id=aggView1464693855909591122.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin1081379497768789417;
