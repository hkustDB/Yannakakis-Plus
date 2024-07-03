create or replace view aggView3218378259358809932 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2072010492123289850 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3218378259358809932 where mi_idx.info_type_id=aggView3218378259358809932.v3;
create or replace view aggView141219800593395901 as select v15 from aggJoin2072010492123289850 group by v15;
create or replace view aggJoin768931770401892696 as select id as v15, title as v16, production_year as v19 from title as t, aggView141219800593395901 where t.id=aggView141219800593395901.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView1553814330970231914 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin768931770401892696 group by v15;
create or replace view aggJoin7985611439268148526 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView1553814330970231914 where mc.movie_id=aggView1553814330970231914.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4408567350263163756 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin754780906446068155 as select v9, v28, v29 from aggJoin7985611439268148526 join aggView4408567350263163756 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin754780906446068155;
