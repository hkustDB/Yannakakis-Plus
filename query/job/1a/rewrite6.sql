create or replace view aggJoin662654914277571112 as (
with aggView2358801354803839383 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView2358801354803839383 where mi_idx.info_type_id=aggView2358801354803839383.v3);
create or replace view aggJoin7744393324115033303 as (
with aggView7976666618651874247 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView7976666618651874247 where mc.company_type_id=aggView7976666618651874247.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%')));
create or replace view aggJoin6387872174825947377 as (
with aggView8306619611772067265 as (select v15, MIN(v9) as v27 from aggJoin7744393324115033303 group by v15)
select v15, v27 from aggJoin662654914277571112 join aggView8306619611772067265 using(v15));
create or replace view aggJoin7113295252406590992 as (
with aggView5405418135572992838 as (select v15, MIN(v27) as v27 from aggJoin6387872174825947377 group by v15,v27)
select title as v16, production_year as v19, v27 from title as t, aggView5405418135572992838 where t.id=aggView5405418135572992838.v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin7113295252406590992;
