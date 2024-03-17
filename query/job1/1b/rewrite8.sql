create or replace view aggView3543158498962880071 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6450318284116020595 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3543158498962880071 where mc.company_type_id=aggView3543158498962880071.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4783336205146686524 as select v15, MIN(v9) as v27 from aggJoin6450318284116020595 group by v15;
create or replace view aggJoin6726760586963361496 as select movie_id as v15, info_type_id as v3, v27 from movie_info_idx as mi_idx, aggView4783336205146686524 where mi_idx.movie_id=aggView4783336205146686524.v15;
create or replace view aggView5149723225289716009 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin3645034322284125871 as select v15, v27 from aggJoin6726760586963361496 join aggView5149723225289716009 using(v3);
create or replace view aggView1600209642032023284 as select v15, MIN(v27) as v27 from aggJoin3645034322284125871 group by v15;
create or replace view aggJoin8907518687502068344 as select title as v16, production_year as v19, v27 from title as t, aggView1600209642032023284 where t.id=aggView1600209642032023284.v15 and production_year<=2010 and production_year>=2005;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin8907518687502068344;
