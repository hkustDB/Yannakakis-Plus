create or replace view aggJoin922552793550584092 as (
with aggView1684652977508259903 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v12 from movie_keyword as mk, aggView1684652977508259903 where mk.keyword_id=aggView1684652977508259903.v1);
create or replace view aggJoin1362196380212348054 as (
with aggView3924499615549346320 as (select v12 from aggJoin922552793550584092 group by v12)
select movie_id as v12, info as v7 from movie_info as mi, aggView3924499615549346320 where mi.movie_id=aggView3924499615549346320.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin2622027966419026005 as (
with aggView2011277501382372767 as (select v12 from aggJoin1362196380212348054 group by v12)
select title as v13, production_year as v16 from title as t, aggView2011277501382372767 where t.id=aggView2011277501382372767.v12 and production_year>1990);
create or replace view aggView1393860461673787 as select v13 from aggJoin2622027966419026005 group by v13;
select MIN(v13) as v24 from aggView1393860461673787;
