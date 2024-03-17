create or replace view aggView7446158649485713103 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin4274966933935377027 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView7446158649485713103 where mi_idx.movie_id=aggView7446158649485713103.v15;
create or replace view aggView4336959739289206171 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin898881680161512911 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4336959739289206171 where mc.company_type_id=aggView4336959739289206171.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4481881926220184857 as select v15, MIN(v9) as v27 from aggJoin898881680161512911 group by v15;
create or replace view aggJoin1343655176144222516 as select v3, v28 as v28, v29 as v29, v27 from aggJoin4274966933935377027 join aggView4481881926220184857 using(v15);
create or replace view aggView1822466029989343084 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin1343655176144222516 group by v3;
create or replace view aggJoin8669077025855016019 as select info as v4, v28, v29, v27 from info_type as it, aggView1822466029989343084 where it.id=aggView1822466029989343084.v3 and info= 'bottom 10 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8669077025855016019;
