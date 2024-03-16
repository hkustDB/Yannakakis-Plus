create or replace view aggView6911830169065286149 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin7846237742685495324 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView6911830169065286149 where ci.movie_id=aggView6911830169065286149.v23;
create or replace view aggView4863735975783648318 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4358537972918294230 as select movie_id as v23, v35 from movie_keyword as mk, aggView4863735975783648318 where mk.keyword_id=aggView4863735975783648318.v8;
create or replace view aggView4919179880315652793 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2664421060764556880 as select v23, v37 from aggJoin7846237742685495324 join aggView4919179880315652793 using(v14);
create or replace view aggView3966905993072868158 as select v23, MIN(v35) as v35 from aggJoin4358537972918294230 group by v23;
create or replace view aggJoin6398481733075121688 as select v37 as v37, v35 from aggJoin2664421060764556880 join aggView3966905993072868158 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6398481733075121688;
