create or replace view aggView8527905352122183251 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin5973691922398518480 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView8527905352122183251 where mi_idx.movie_id=aggView8527905352122183251.v15;
create or replace view aggView3465452673424437614 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin1842029136273577759 as select v15, v28, v29 from aggJoin5973691922398518480 join aggView3465452673424437614 using(v3);
create or replace view aggView9040600203196742693 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin1842029136273577759 group by v15;
create or replace view aggJoin5008766478472026322 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView9040600203196742693 where mc.movie_id=aggView9040600203196742693.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView255012403423793893 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin5008766478472026322 group by v1;
create or replace view aggJoin8053004258380155856 as select kind as v2, v28, v29, v27 from company_type as ct, aggView255012403423793893 where ct.id=aggView255012403423793893.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8053004258380155856;
