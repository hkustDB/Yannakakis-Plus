create or replace view aggView2420452686938925725 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin6290752186120177341 as select movie_id as v15 from movie_info_idx as mi_idx, aggView2420452686938925725 where mi_idx.info_type_id=aggView2420452686938925725.v3;
create or replace view aggView1515625476931001476 as select v15 from aggJoin6290752186120177341 group by v15;
create or replace view aggJoin4555359093542870098 as select id as v15, title as v16, production_year as v19 from title as t, aggView1515625476931001476 where t.id=aggView1515625476931001476.v15 and production_year>2010;
create or replace view aggView5106989182244504137 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin4555359093542870098 group by v15;
create or replace view aggJoin909307073749784949 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView5106989182244504137 where mc.movie_id=aggView5106989182244504137.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8386055864721469194 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1168492597836648304 as select v9, v28, v29 from aggJoin909307073749784949 join aggView8386055864721469194 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1168492597836648304;
