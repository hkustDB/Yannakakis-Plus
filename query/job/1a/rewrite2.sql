create or replace view aggView2473701579331312694 as select production_year as v19, id as v15, title as v16 from title as t;
create or replace view aggJoin1098157280967119665 as (
with aggView5861544899192890307 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView5861544899192890307 where mi_idx.info_type_id=aggView5861544899192890307.v3);
create or replace view aggJoin1155196291859613689 as (
with aggView5042676386092824432 as (select v15 from aggJoin1098157280967119665 group by v15)
select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView5042676386092824432 where mc.movie_id=aggView5042676386092824432.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%')));
create or replace view aggJoin1629109917112490322 as (
with aggView3326898887424495429 as (select id as v1 from company_type as ct where kind= 'production companies')
select v15, v9 from aggJoin1155196291859613689 join aggView3326898887424495429 using(v1));
create or replace view aggView3753754187363056195 as select v15, v9 from aggJoin1629109917112490322 group by v15,v9;
create or replace view aggJoin2305830382435720740 as (
with aggView8281275192464942783 as (select v15, MIN(v16) as v28, MIN(v19) as v29 from aggView2473701579331312694 group by v15)
select v9, v28, v29 from aggView3753754187363056195 join aggView8281275192464942783 using(v15));
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2305830382435720740;
