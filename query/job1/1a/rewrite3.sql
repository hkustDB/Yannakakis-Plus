create or replace view aggView6155787638557835996 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin6402533943660814865 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6155787638557835996 where mc.movie_id=aggView6155787638557835996.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView3132339303257322179 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3124609830127943945 as select v15, v9, v28, v29 from aggJoin6402533943660814865 join aggView3132339303257322179 using(v1);
create or replace view aggView8241436853216887460 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin3124609830127943945 group by v15;
create or replace view aggJoin8427913776862524328 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView8241436853216887460 where mi_idx.movie_id=aggView8241436853216887460.v15;
create or replace view aggView2884483398358393159 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin8427913776862524328 group by v3;
create or replace view aggJoin8614230899296789030 as select info as v4, v28, v29, v27 from info_type as it, aggView2884483398358393159 where it.id=aggView2884483398358393159.v3 and info= 'top 250 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8614230899296789030;
