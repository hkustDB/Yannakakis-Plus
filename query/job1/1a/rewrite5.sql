create or replace view aggView692361308521637850 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin8204500365422946861 as select movie_id as v15 from movie_info_idx as mi_idx, aggView692361308521637850 where mi_idx.info_type_id=aggView692361308521637850.v3;
create or replace view aggView6734729693725160955 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7313668313752483216 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6734729693725160955 where mc.company_type_id=aggView6734729693725160955.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView8588426316360671827 as select v15, MIN(v9) as v27 from aggJoin7313668313752483216 group by v15;
create or replace view aggJoin5127442394380088079 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView8588426316360671827 where t.id=aggView8588426316360671827.v15;
create or replace view aggView748347508370312959 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin5127442394380088079 group by v15;
create or replace view aggJoin6852926957120150611 as select v27, v28, v29 from aggJoin8204500365422946861 join aggView748347508370312959 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6852926957120150611;
