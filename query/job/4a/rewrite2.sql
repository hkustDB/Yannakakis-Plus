create or replace view aggJoin1559778476740077366 as (
with aggView3313248635428410177 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView3313248635428410177 where mk.keyword_id=aggView3313248635428410177.v3);
create or replace view aggJoin4938800828770886490 as (
with aggView6062001264340575474 as (select v14 from aggJoin1559778476740077366 group by v14)
select id as v14, title as v15, production_year as v18 from title as t, aggView6062001264340575474 where t.id=aggView6062001264340575474.v14 and production_year>2005);
create or replace view aggView5409210293542572992 as select v14, v15 from aggJoin4938800828770886490 group by v14,v15;
create or replace view aggJoin5894097087610380059 as (
with aggView4899818968539357052 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4899818968539357052 where mi_idx.info_type_id=aggView4899818968539357052.v1);
create or replace view aggJoin3330384788412957096 as (
with aggView8223949489800718641 as (select v9, v14 from aggJoin5894097087610380059 group by v9,v14)
select v14, v9 from aggView8223949489800718641 where v9>'5.0');
create or replace view aggJoin1313601734067492674 as (
with aggView8185928818918025008 as (select v14, MIN(v15) as v27 from aggView5409210293542572992 group by v14)
select v9, v27 from aggJoin3330384788412957096 join aggView8185928818918025008 using(v14));
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin1313601734067492674;
