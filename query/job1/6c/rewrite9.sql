create or replace view aggView504372023194159546 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7134463011017093237 as select movie_id as v23, v35 from movie_keyword as mk, aggView504372023194159546 where mk.keyword_id=aggView504372023194159546.v8;
create or replace view aggView8743428606065713576 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4177476987688034492 as select movie_id as v23, v36 from cast_info as ci, aggView8743428606065713576 where ci.person_id=aggView8743428606065713576.v14;
create or replace view aggView4477093118614527226 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin8819804645912022417 as select v23, v35, v37 from aggJoin7134463011017093237 join aggView4477093118614527226 using(v23);
create or replace view aggView266920953629361508 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin8819804645912022417 group by v23;
create or replace view aggJoin5407504543902619789 as select v36 as v36, v35, v37 from aggJoin4177476987688034492 join aggView266920953629361508 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5407504543902619789;
