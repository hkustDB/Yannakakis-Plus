create or replace view aggJoin4147209497779410523 as (
with aggView8814843606099145528 as (select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView8814843606099145528 where mk.movie_id=aggView8814843606099145528.v12);
create or replace view aggJoin8450918813734839931 as (
with aggView8693113328348087161 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select v12 from aggJoin4147209497779410523 join aggView8693113328348087161 using(v1));
create or replace view aggJoin953905728004263213 as (
with aggView8516977649293664118 as (select v12 from aggJoin8450918813734839931 group by v12)
select title as v13, production_year as v16 from title as t, aggView8516977649293664118 where t.id=aggView8516977649293664118.v12 and production_year>2005);
create or replace view aggView3442769918546283421 as select v13 from aggJoin953905728004263213 group by v13;
select MIN(v13) as v24 from aggView3442769918546283421;
