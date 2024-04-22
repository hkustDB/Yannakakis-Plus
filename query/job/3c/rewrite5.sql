create or replace view aggJoin1011390068559013147 as (
with aggView5678089431624213604 as (select id as v12, title as v24 from title as t where production_year>1990)
select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView5678089431624213604 where mk.movie_id=aggView5678089431624213604.v12);
create or replace view aggJoin5989479702961522631 as (
with aggView3433004161549985404 as (select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id)
select v1, v24 as v24 from aggJoin1011390068559013147 join aggView3433004161549985404 using(v12));
create or replace view aggJoin4825970806629510582 as (
with aggView4883780345703299255 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select v24 from aggJoin5989479702961522631 join aggView4883780345703299255 using(v1));
select MIN(v24) as v24 from aggJoin4825970806629510582;
