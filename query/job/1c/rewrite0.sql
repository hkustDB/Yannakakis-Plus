create or replace view aggView7080912951871904541 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin7249522988697932328 as select movie_id as v15 from movie_info_idx as mi_idx, aggView7080912951871904541 where mi_idx.info_type_id=aggView7080912951871904541.v3;
create or replace view aggView8927793301678246241 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5444078888176334560 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8927793301678246241 where mc.company_type_id=aggView8927793301678246241.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3086775927954003672 as select v15 from aggJoin7249522988697932328 group by v15;
create or replace view aggJoin2030944239771621310 as select id as v15, title as v16, production_year as v19 from title as t, aggView3086775927954003672 where t.id=aggView3086775927954003672.v15 and production_year>2010;
create or replace view aggView7137771648511403717 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin2030944239771621310 group by v15;
create or replace view aggJoin5906459832856020185 as select v9, v28, v29 from aggJoin5444078888176334560 join aggView7137771648511403717 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5906459832856020185;
