create or replace view aggView971223733658904280 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1485455237465591923 as select movie_id as v23, v36 from cast_info as ci, aggView971223733658904280 where ci.person_id=aggView971223733658904280.v14;
create or replace view aggView8373774747902402566 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4415381615388193301 as select movie_id as v23, v35 from movie_keyword as mk, aggView8373774747902402566 where mk.keyword_id=aggView8373774747902402566.v8;
create or replace view aggView8309947481504678632 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin101167044739976749 as select v23, v35, v37 from aggJoin4415381615388193301 join aggView8309947481504678632 using(v23);
create or replace view aggView1396218563938784120 as select v23, MIN(v36) as v36 from aggJoin1485455237465591923 group by v23;
create or replace view aggJoin1051378050834806858 as select v35 as v35, v37 as v37, v36 from aggJoin101167044739976749 join aggView1396218563938784120 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1051378050834806858;
