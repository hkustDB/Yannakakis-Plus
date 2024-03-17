create or replace view aggView3163822381695813087 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin8396819839827398289 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView3163822381695813087 where mc.movie_id=aggView3163822381695813087.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView3627296744269755207 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin3676759695769220090 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3627296744269755207 where mi_idx.info_type_id=aggView3627296744269755207.v3;
create or replace view aggView7885202005312374211 as select v15 from aggJoin3676759695769220090 group by v15;
create or replace view aggJoin4599684015104510169 as select v1, v9, v28 as v28, v29 as v29 from aggJoin8396819839827398289 join aggView7885202005312374211 using(v15);
create or replace view aggView8931225497222267514 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin4599684015104510169 group by v1;
create or replace view aggJoin2745607792872108006 as select kind as v2, v28, v29, v27 from company_type as ct, aggView8931225497222267514 where ct.id=aggView8931225497222267514.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2745607792872108006;
