create or replace view aggView3043849886021757964 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin3858401341470255166 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView3043849886021757964 where ci.movie_id=aggView3043849886021757964.v23;
create or replace view aggView5086750528019963909 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin8195199727486011408 as select movie_id as v23, v35 from movie_keyword as mk, aggView5086750528019963909 where mk.keyword_id=aggView5086750528019963909.v8;
create or replace view aggView1069672130309413773 as select v23, MIN(v35) as v35 from aggJoin8195199727486011408 group by v23;
create or replace view aggJoin2702463605400746242 as select v14, v37 as v37, v35 from aggJoin3858401341470255166 join aggView1069672130309413773 using(v23);
create or replace view aggView5888595575539114250 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin2702463605400746242 group by v14;
create or replace view aggJoin3911609177783416595 as select name as v15, v37, v35 from name as n, aggView5888595575539114250 where n.id=aggView5888595575539114250.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin3911609177783416595;
