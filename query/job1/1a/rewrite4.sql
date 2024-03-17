create or replace view aggView9096926781346786589 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin6213592989390654141 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView9096926781346786589 where mc.movie_id=aggView9096926781346786589.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView3528953469309572020 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin2554428313309946684 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3528953469309572020 where mi_idx.info_type_id=aggView3528953469309572020.v3;
create or replace view aggView5022055315669747813 as select v15 from aggJoin2554428313309946684 group by v15;
create or replace view aggJoin806673573258622442 as select v1, v9, v28 as v28, v29 as v29 from aggJoin6213592989390654141 join aggView5022055315669747813 using(v15);
create or replace view aggView2496989718526987249 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin806673573258622442 group by v1;
create or replace view aggJoin5875509213261239635 as select kind as v2, v28, v29, v27 from company_type as ct, aggView2496989718526987249 where ct.id=aggView2496989718526987249.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5875509213261239635;
