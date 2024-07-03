create or replace view aggView8730965770828364399 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin2689867940349146451 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView8730965770828364399 where mk.movie_id=aggView8730965770828364399.v23;
create or replace view aggView2634176034274903639 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7270938608528313303 as select v23, v37, v35 from aggJoin2689867940349146451 join aggView2634176034274903639 using(v8);
create or replace view aggView7854354440770883111 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4516628264789062166 as select movie_id as v23, v36 from cast_info as ci, aggView7854354440770883111 where ci.person_id=aggView7854354440770883111.v14;
create or replace view aggView4208650579785223112 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin7270938608528313303 group by v23,v37,v35;
create or replace view aggJoin7071931108945583142 as select v36 as v36, v37, v35 from aggJoin4516628264789062166 join aggView4208650579785223112 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7071931108945583142;
