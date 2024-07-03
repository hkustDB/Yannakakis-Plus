create or replace view aggView6638941873738282 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin6580797042187565317 as select movie_id as v15 from movie_info_idx as mi_idx, aggView6638941873738282 where mi_idx.info_type_id=aggView6638941873738282.v3;
create or replace view aggView8033015529976326544 as select v15 from aggJoin6580797042187565317 group by v15;
create or replace view aggJoin5373315061265632221 as select id as v15, title as v16, production_year as v19 from title as t, aggView8033015529976326544 where t.id=aggView8033015529976326544.v15 and production_year>2000;
create or replace view aggView4344528213497844626 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1233931142652689400 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4344528213497844626 where mc.company_type_id=aggView4344528213497844626.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView6106615517249808181 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin5373315061265632221 group by v15;
create or replace view aggJoin2054024015214028619 as select v9, v28, v29 from aggJoin1233931142652689400 join aggView6106615517249808181 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2054024015214028619;
