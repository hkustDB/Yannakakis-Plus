create or replace view aggView8096903239747956301 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin1447277344709071685 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView8096903239747956301 where ci.movie_id=aggView8096903239747956301.v23;
create or replace view aggView1673992885577730521 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin4583757507726985889 as select movie_id as v23, v35 from movie_keyword as mk, aggView1673992885577730521 where mk.keyword_id=aggView1673992885577730521.v8;
create or replace view aggView7116393717743578765 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin878139653661095009 as select v23, v37 from aggJoin1447277344709071685 join aggView7116393717743578765 using(v14);
create or replace view aggView368716746780298305 as select v23, MIN(v35) as v35 from aggJoin4583757507726985889 group by v23;
create or replace view aggJoin2313929463700379072 as select v37 as v37, v35 from aggJoin878139653661095009 join aggView368716746780298305 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2313929463700379072;
