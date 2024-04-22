create or replace view aggJoin3322526694077711830 as (
with aggView8127308963817316054 as (select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005)
select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView8127308963817316054 where mc.movie_id=aggView8127308963817316054.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggJoin6317757399628650411 as (
with aggView361700381001618796 as (select id as v3 from info_type as it where info= 'bottom 10 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView361700381001618796 where mi_idx.info_type_id=aggView361700381001618796.v3);
create or replace view aggJoin1762456026500421978 as (
with aggView3097659327934319678 as (select id as v1 from company_type as ct where kind= 'production companies')
select v15, v9, v28, v29 from aggJoin3322526694077711830 join aggView3097659327934319678 using(v1));
create or replace view aggJoin1497116663489842971 as (
with aggView3882592460850060820 as (select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin1762456026500421978 group by v15,v29,v28)
select v28, v29, v27 from aggJoin6317757399628650411 join aggView3882592460850060820 using(v15));
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1497116663489842971;
