create or replace view aggView5990369404081146225 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin3198893325132569380 as select movie_id as v15 from movie_info_idx as mi_idx, aggView5990369404081146225 where mi_idx.info_type_id=aggView5990369404081146225.v3;
create or replace view aggView6564496558433122914 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2617431568747720643 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6564496558433122914 where mc.company_type_id=aggView6564496558433122914.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3001364707209969975 as select v15, MIN(v9) as v27 from aggJoin2617431568747720643 group by v15;
create or replace view aggJoin7258999987320535053 as select v15, v27 from aggJoin3198893325132569380 join aggView3001364707209969975 using(v15);
create or replace view aggView1857982700995909266 as select v15, MIN(v27) as v27 from aggJoin7258999987320535053 group by v15;
create or replace view aggJoin1869788995640188087 as select title as v16, production_year as v19, v27 from title as t, aggView1857982700995909266 where t.id=aggView1857982700995909266.v15 and production_year>2000;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin1869788995640188087;
