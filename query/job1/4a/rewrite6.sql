create or replace view aggView3658202364772559591 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1929842995976833426 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3658202364772559591 where mi_idx.info_type_id=aggView3658202364772559591.v1 and info>'5.0';
create or replace view aggView704194101530140868 as select v14, MIN(v9) as v26 from aggJoin1929842995976833426 group by v14;
create or replace view aggJoin3610934525209876076 as select movie_id as v14, keyword_id as v3, v26 from movie_keyword as mk, aggView704194101530140868 where mk.movie_id=aggView704194101530140868.v14;
create or replace view aggView3995938130932135664 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4529178743909422743 as select v14, v26 from aggJoin3610934525209876076 join aggView3995938130932135664 using(v3);
create or replace view aggView6047461872553950289 as select v14, MIN(v26) as v26 from aggJoin4529178743909422743 group by v14;
create or replace view aggJoin8297530712597829077 as select title as v15, v26 from title as t, aggView6047461872553950289 where t.id=aggView6047461872553950289.v14 and production_year>2005;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin8297530712597829077;
