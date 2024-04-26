create or replace view aggView7380406611385573949 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5573801143534006285 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7380406611385573949 where mc.company_type_id=aggView7380406611385573949.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView6391325723262367799 as select v15, MIN(v9) as v27 from aggJoin5573801143534006285 group by v15;
create or replace view aggJoin2952095694969207927 as select movie_id as v15, info_type_id as v3, v27 from movie_info_idx as mi_idx, aggView6391325723262367799 where mi_idx.movie_id=aggView6391325723262367799.v15;
create or replace view aggView3944416048044575281 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin5416783882082787452 as select v15, v27 from aggJoin2952095694969207927 join aggView3944416048044575281 using(v3);
create or replace view aggView6578934886244115719 as select v15, MIN(v27) as v27 from aggJoin5416783882082787452 group by v15;
create or replace view aggJoin1195455070877254710 as select title as v16, production_year as v19, v27 from title as t, aggView6578934886244115719 where t.id=aggView6578934886244115719.v15;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin1195455070877254710;
