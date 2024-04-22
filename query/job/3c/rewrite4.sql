create or replace view aggJoin4588204653033733432 as (
with aggView4456486547310965677 as (select id as v12, title as v24 from title as t where production_year>1990)
select movie_id as v12, info as v7, v24 from movie_info as mi, aggView4456486547310965677 where mi.movie_id=aggView4456486547310965677.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin3951859525918030704 as (
with aggView2285353286399610866 as (select v12, MIN(v24) as v24 from aggJoin4588204653033733432 group by v12,v24)
select keyword_id as v1, v24 from movie_keyword as mk, aggView2285353286399610866 where mk.movie_id=aggView2285353286399610866.v12);
create or replace view aggJoin2209100982505939978 as (
with aggView5377304867772072237 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select v24 from aggJoin3951859525918030704 join aggView5377304867772072237 using(v1));
select MIN(v24) as v24 from aggJoin2209100982505939978;
