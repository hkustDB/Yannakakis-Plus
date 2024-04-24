create or replace view aggView1500891273468261238 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin4023777408980723056 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1500891273468261238 where mi_idx.info_type_id=aggView1500891273468261238.v3;
create or replace view aggView2064338959560814757 as select v15 from aggJoin4023777408980723056 group by v15;
create or replace view aggJoin5531010807490290500 as select id as v15, title as v16, production_year as v19 from title as t, aggView2064338959560814757 where t.id=aggView2064338959560814757.v15 and production_year>2000;
create or replace view aggView6253339793641844564 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2439203147724622716 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6253339793641844564 where mc.company_type_id=aggView6253339793641844564.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1445011944281184586 as select v15, MIN(v9) as v27 from aggJoin2439203147724622716 group by v15;
create or replace view aggJoin8760656268716701711 as select v16, v19, v27 from aggJoin5531010807490290500 join aggView1445011944281184586 using(v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin8760656268716701711;
