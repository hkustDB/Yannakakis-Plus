create or replace view aggView8862969589195767842 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin1879526093169480320 as select movie_id as v15 from movie_info_idx as mi_idx, aggView8862969589195767842 where mi_idx.info_type_id=aggView8862969589195767842.v3;
create or replace view aggView6377634225779822656 as select v15 from aggJoin1879526093169480320 group by v15;
create or replace view aggJoin8840179606750880587 as select id as v15, title as v16, production_year as v19 from title as t, aggView6377634225779822656 where t.id=aggView6377634225779822656.v15 and production_year>2010;
create or replace view aggView8345605641111294963 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin8840179606750880587 group by v15;
create or replace view aggJoin7799819265047564128 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView8345605641111294963 where mc.movie_id=aggView8345605641111294963.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView6916035814994815508 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin7799819265047564128 group by v1;
create or replace view aggJoin981325119142700619 as select v28, v29, v27 from company_type as ct, aggView6916035814994815508 where ct.id=aggView6916035814994815508.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin981325119142700619;
