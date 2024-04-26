create or replace view aggView96315091030277407 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6232719135292971320 as select movie_id as v15, note as v9 from movie_companies as mc, aggView96315091030277407 where mc.company_type_id=aggView96315091030277407.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView4217428481362769703 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin5283310252624745780 as select movie_id as v15 from movie_info_idx as mi_idx, aggView4217428481362769703 where mi_idx.info_type_id=aggView4217428481362769703.v3;
create or replace view aggView3242165316593362422 as select v15 from aggJoin5283310252624745780 group by v15;
create or replace view aggJoin9152453337895854695 as select v15, v9 from aggJoin6232719135292971320 join aggView3242165316593362422 using(v15);
create or replace view aggView60437358125551322 as select v15, MIN(v9) as v27 from aggJoin9152453337895854695 group by v15;
create or replace view aggJoin4392717395553476105 as select title as v16, production_year as v19, v27 from title as t, aggView60437358125551322 where t.id=aggView60437358125551322.v15;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin4392717395553476105;
