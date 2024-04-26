create or replace view aggView894903852071447108 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4063521588467444793 as select movie_id as v15, note as v9 from movie_companies as mc, aggView894903852071447108 where mc.company_type_id=aggView894903852071447108.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView8737161413976975091 as select v15, MIN(v9) as v27 from aggJoin4063521588467444793 group by v15;
create or replace view aggJoin632023649417322685 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView8737161413976975091 where t.id=aggView8737161413976975091.v15;
create or replace view aggView1529306195498018768 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin3927947758175364964 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1529306195498018768 where mi_idx.info_type_id=aggView1529306195498018768.v3;
create or replace view aggView7912550380203504453 as select v15 from aggJoin3927947758175364964 group by v15;
create or replace view aggJoin39668419452797645 as select v16, v19, v27 as v27 from aggJoin632023649417322685 join aggView7912550380203504453 using(v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin39668419452797645;
