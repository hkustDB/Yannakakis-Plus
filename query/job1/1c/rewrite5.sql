create or replace view aggView8336669523271753169 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin2688095615057833748 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView8336669523271753169 where mc.movie_id=aggView8336669523271753169.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1945580699071199957 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2918443761404989028 as select v15, v9, v28, v29 from aggJoin2688095615057833748 join aggView1945580699071199957 using(v1);
create or replace view aggView2050396765006038676 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin2918443761404989028 group by v15;
create or replace view aggJoin3180480588837488137 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView2050396765006038676 where mi_idx.movie_id=aggView2050396765006038676.v15;
create or replace view aggView2594858782349687077 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin3180480588837488137 group by v3;
create or replace view aggJoin9022779060429744632 as select info as v4, v28, v29, v27 from info_type as it, aggView2594858782349687077 where it.id=aggView2594858782349687077.v3 and info= 'top 250 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin9022779060429744632;
