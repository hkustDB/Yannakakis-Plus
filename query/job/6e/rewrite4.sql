create or replace view aggView1994142789209131975 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin4962100758702075174 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView1994142789209131975 where mk.movie_id=aggView1994142789209131975.v23;
create or replace view aggView3118163115816287909 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2712395133011907092 as select movie_id as v23, v36 from cast_info as ci, aggView3118163115816287909 where ci.person_id=aggView3118163115816287909.v14;
create or replace view aggView7487861481924897018 as select v23, MIN(v36) as v36 from aggJoin2712395133011907092 group by v23;
create or replace view aggJoin8517450646453141927 as select v8, v37 as v37, v36 from aggJoin4962100758702075174 join aggView7487861481924897018 using(v23);
create or replace view aggView1983336732181169010 as select v8, MIN(v37) as v37, MIN(v36) as v36 from aggJoin8517450646453141927 group by v8;
create or replace view aggJoin4572357099580307472 as select keyword as v9, v37, v36 from keyword as k, aggView1983336732181169010 where k.id=aggView1983336732181169010.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4572357099580307472;
