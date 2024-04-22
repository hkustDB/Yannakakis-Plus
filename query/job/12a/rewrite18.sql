create or replace view aggJoin1275662559155274642 as (
with aggView5156493772003047408 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView5156493772003047408 where mc.company_id=aggView5156493772003047408.v1);
create or replace view aggJoin9171235471141033701 as (
with aggView4090415060894996832 as (select id as v29, title as v43 from title as t where production_year<=2008 and production_year>=2005)
select movie_id as v29, info_type_id as v21, info as v22, v43 from movie_info as mi, aggView4090415060894996832 where mi.movie_id=aggView4090415060894996832.v29 and info IN ('Drama','Horror'));
create or replace view aggJoin5536907945507016564 as (
with aggView8053413357947048645 as (select id as v21 from info_type as it1 where info= 'genres')
select v29, v22, v43 from aggJoin9171235471141033701 join aggView8053413357947048645 using(v21));
create or replace view aggJoin3964732195968267610 as (
with aggView4049669195160362550 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin1275662559155274642 join aggView4049669195160362550 using(v8));
create or replace view aggJoin3461005242813093788 as (
with aggView4246092956283977435 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView4246092956283977435 where mi_idx.info_type_id=aggView4246092956283977435.v26 and info>'8.0');
create or replace view aggJoin2461210742092720465 as (
with aggView1087477897644153942 as (select v29, MIN(v27) as v42 from aggJoin3461005242813093788 group by v29)
select v29, v22, v43 as v43, v42 from aggJoin5536907945507016564 join aggView1087477897644153942 using(v29));
create or replace view aggJoin4259572888251004840 as (
with aggView6554212836744626868 as (select v29, MIN(v43) as v43, MIN(v42) as v42 from aggJoin2461210742092720465 group by v29,v43,v42)
select v41 as v41, v43, v42 from aggJoin3964732195968267610 join aggView6554212836744626868 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin4259572888251004840;
