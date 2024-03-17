create or replace view aggView3015860721720461803 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1651853493873934976 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3015860721720461803 where mc.company_type_id=aggView3015860721720461803.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView2401490642933167802 as select v15, MIN(v9) as v27 from aggJoin1651853493873934976 group by v15;
create or replace view aggJoin4753134326795873451 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView2401490642933167802 where t.id=aggView2401490642933167802.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView7580726333938888792 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin4753134326795873451 group by v15;
create or replace view aggJoin7290643607252623589 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView7580726333938888792 where mi_idx.movie_id=aggView7580726333938888792.v15;
create or replace view aggView3818306152074393231 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin6659500440578035646 as select v27, v28, v29 from aggJoin7290643607252623589 join aggView3818306152074393231 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6659500440578035646;
