create or replace view aggView3321284236459593348 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8555600869397864239 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3321284236459593348 where mc.company_type_id=aggView3321284236459593348.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1088556020099116560 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin7307994116696836788 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1088556020099116560 where mi_idx.info_type_id=aggView1088556020099116560.v3;
create or replace view aggView5876704870176377057 as select v15 from aggJoin7307994116696836788 group by v15;
create or replace view aggJoin1450793321272812741 as select id as v15, title as v16, production_year as v19 from title as t, aggView5876704870176377057 where t.id=aggView5876704870176377057.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView1033353685470463268 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin1450793321272812741 group by v15;
create or replace view aggJoin5082004269785924398 as select v9, v28, v29 from aggJoin8555600869397864239 join aggView1033353685470463268 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5082004269785924398;
