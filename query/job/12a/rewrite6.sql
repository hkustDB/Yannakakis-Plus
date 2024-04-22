create or replace view aggView6070811084486240699 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggView6524100977546752335 as select title as v30, id as v29 from title as t where production_year<=2008 and production_year>=2005;
create or replace view aggJoin1631264827625430365 as (
with aggView3872272284151860213 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView3872272284151860213 where mi.info_type_id=aggView3872272284151860213.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin3993164418564875929 as (
with aggView9055464297034080604 as (select v29 from aggJoin1631264827625430365 group by v29)
select movie_id as v29, info_type_id as v26, info as v27 from movie_info_idx as mi_idx, aggView9055464297034080604 where mi_idx.movie_id=aggView9055464297034080604.v29);
create or replace view aggJoin2261837422673373215 as (
with aggView4889540238685115227 as (select id as v26 from info_type as it2 where info= 'rating')
select v29, v27 from aggJoin3993164418564875929 join aggView4889540238685115227 using(v26));
create or replace view aggJoin68274461223567809 as (
with aggView5289014695533214051 as (select v27, v29 from aggJoin2261837422673373215 group by v27,v29)
select v29, v27 from aggView5289014695533214051 where v27>'8.0');
create or replace view aggJoin6009764541681531297 as (
with aggView4930344170333839450 as (select v1, MIN(v2) as v41 from aggView6070811084486240699 group by v1)
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView4930344170333839450 where mc.company_id=aggView4930344170333839450.v1);
create or replace view aggJoin8859782852120687639 as (
with aggView8044471064709900592 as (select v29, MIN(v27) as v42 from aggJoin68274461223567809 group by v29)
select v30, v29, v42 from aggView6524100977546752335 join aggView8044471064709900592 using(v29));
create or replace view aggJoin2366104410638197474 as (
with aggView6338491179470029760 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin6009764541681531297 join aggView6338491179470029760 using(v8));
create or replace view aggJoin5796328183963347394 as (
with aggView2678099202091731909 as (select v29, MIN(v41) as v41 from aggJoin2366104410638197474 group by v29,v41)
select v30, v42 as v42, v41 from aggJoin8859782852120687639 join aggView2678099202091731909 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v30) as v43 from aggJoin5796328183963347394;
