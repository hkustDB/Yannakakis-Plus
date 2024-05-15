create or replace view aggView4645486017147137285 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin1175143604842963290 as select movie_id as v15 from movie_info_idx as mi_idx, aggView4645486017147137285 where mi_idx.info_type_id=aggView4645486017147137285.v3;
create or replace view aggView3569978259571691828 as select v15 from aggJoin1175143604842963290 group by v15;
create or replace view aggJoin3502505965369877325 as select id as v15, title as v16, production_year as v19 from title as t, aggView3569978259571691828 where t.id=aggView3569978259571691828.v15 and production_year>2000;
create or replace view aggView3434926264331877022 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin3502505965369877325 group by v15;
create or replace view aggJoin5101563546099564632 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView3434926264331877022 where mc.movie_id=aggView3434926264331877022.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView790495240243280343 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8761955553876231686 as select v9, v28, v29 from aggJoin5101563546099564632 join aggView790495240243280343 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8761955553876231686;
