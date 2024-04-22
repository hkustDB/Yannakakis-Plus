create or replace view aggJoin2316248665822463737 as (
with aggView2363559666166512484 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v12 from movie_keyword as mk, aggView2363559666166512484 where mk.keyword_id=aggView2363559666166512484.v1);
create or replace view aggJoin7274638191580672725 as (
with aggView4424781279409178891 as (select v12 from aggJoin2316248665822463737 group by v12)
select movie_id as v12, info as v7 from movie_info as mi, aggView4424781279409178891 where mi.movie_id=aggView4424781279409178891.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin762335117349094605 as (
with aggView5867315593171668727 as (select v12 from aggJoin7274638191580672725 group by v12)
select title as v13, production_year as v16 from title as t, aggView5867315593171668727 where t.id=aggView5867315593171668727.v12 and production_year>2005);
create or replace view aggView8097221953669900441 as select v13 from aggJoin762335117349094605 group by v13;
select MIN(v13) as v24 from aggView8097221953669900441;
