create or replace view aggJoin3417426614351413827 as (
with aggView3869867050406175142 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3869867050406175142 where mi_idx.info_type_id=aggView3869867050406175142.v1 and info>'2.0');
create or replace view aggJoin7728639786520789280 as (
with aggView523822601055002380 as (select v14, MIN(v9) as v26 from aggJoin3417426614351413827 group by v14)
select id as v14, title as v15, production_year as v18, v26 from title as t, aggView523822601055002380 where t.id=aggView523822601055002380.v14 and production_year>1990);
create or replace view aggJoin6777236098848091603 as (
with aggView5927528504640812488 as (select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin7728639786520789280 group by v14,v26)
select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView5927528504640812488 where mk.movie_id=aggView5927528504640812488.v14);
create or replace view aggJoin740136292979639 as (
with aggView6977882256188646827 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select v26, v27 from aggJoin6777236098848091603 join aggView6977882256188646827 using(v3));
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin740136292979639;
